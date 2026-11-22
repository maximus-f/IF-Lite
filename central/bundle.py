"""Package the verified library build for the Sonatype Central Portal."""
import argparse
import hashlib
from pathlib import Path
import shutil
import subprocess
import tempfile
import xml.etree.ElementTree as ET
from zipfile import ZIP_DEFLATED, ZipFile

ROOT = Path(__file__).resolve().parents[1]
POM = ROOT / "central/pom.xml"

from urllib.request import urlopen


def download(url, expected_sha256):
    with urlopen(url, timeout=90) as response:
        data = response.read()
    if hashlib.sha256(data).hexdigest() != expected_sha256:
        raise ValueError("Upstream checksum mismatch for " + url)
    return data


def copy_artifacts(folder, artifact, version):
    import io

    jar = ROOT / "target" / f"IF-Lite-{version}.jar"
    shutil.copyfile(jar, folder / f"{artifact}-{version}.jar")
    source = download(
        f"https://codeload.github.com/stefvanschie/IF/zip/refs/tags/v{version}",
        "8ff72e3aaa6983fdb971c8279cdd68ee1329fbacef6d308b4bf049c79779c475",
    )
    with ZipFile(jar) as binary:
        wanted = {name[:-6].split("$")[0] + ".java" for name in binary.namelist() if name.endswith(".class")}
    with ZipFile(io.BytesIO(source)) as upstream, ZipFile(folder / f"{artifact}-{version}-sources.jar", "w", ZIP_DEFLATED) as out:
        for name in upstream.namelist():
            relative = name.partition("/src/main/java/")[2]
            if relative in wanted:
                out.writestr(relative, upstream.read(name))
                wanted.remove(relative)
        if wanted:
            raise ValueError(f"Missing upstream sources: {sorted(wanted)}")
        out.write(ROOT / "LICENSE", "META-INF/IF-Lite/LICENSE")

    docs = download(
        f"https://repo.maven.apache.org/maven2/com/github/stefvanschie/inventoryframework/IF/{version}/IF-{version}-javadoc.jar",
        "e30111bd34284ebf8401d1f4879d5425f99a43d93200af463920fc477760f4e3",
    )
    (folder / f"{artifact}-{version}-javadoc.jar").write_bytes(docs)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument("--stage", type=Path, metavar="REPOSITORY", help="Write unsigned artifacts for a local consumer test")
    mode.add_argument("--signing-key", metavar="FINGERPRINT", help="Sign the upload bundle using this GnuPG key")
    args = parser.parse_args()
    model = ET.parse(POM).getroot()
    group, artifact, version = (model.findtext("{*}" + k) for k in ("groupId", "artifactId", "version"))
    relative = Path(*group.split("."), artifact, version)
    stem = f"{artifact}-{version}"
    with tempfile.TemporaryDirectory() as tmp:
        work = Path(tmp)
        folder = work / relative
        folder.mkdir(parents=True)
        copy_artifacts(folder, artifact, version)
        shutil.copyfile(POM, folder / (stem + ".pom"))
        for file in sorted(folder.iterdir()):
            data = file.read_bytes()
            for algorithm in ("md5", "sha1", "sha256", "sha512"):
                digest = hashlib.new(algorithm, data).hexdigest()
                file.with_name(file.name + "." + algorithm).write_text(digest + "\n")
            if args.signing_key:
                subprocess.run(["gpg", "--local-user", args.signing_key, "--armor", "--detach-sign", str(file)], check=True)
                subprocess.run(["gpg", "--verify", str(file) + ".asc", str(file)], check=True)

        if args.stage:
            destination = args.stage.resolve() / relative
            destination.parent.mkdir(parents=True, exist_ok=True)
            shutil.copytree(folder, destination)
            print(destination)
        else:
            output = ROOT / "target" / (stem + "-central.zip")
            output.parent.mkdir(exist_ok=True)
            with ZipFile(work / "bundle.zip", "w", ZIP_DEFLATED) as bundle:
                for file in sorted(folder.iterdir()):
                    bundle.write(file, file.relative_to(work))
            shutil.copyfile(work / "bundle.zip", output)
            print(output)


if __name__ == "__main__":
    main()
