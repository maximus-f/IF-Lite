# IF-Lite 0.12.2

IF-Lite packages the shared chest-menu and paging classes from InventoryFramework for plugins that use Bukkit inventories. The JAR contains 107 unmodified classes from IF 0.12.2, including both inventory-view implementations. It omits the version-specific NMS inventories and bundled font resources. The upstream Unlicense is included.

[Download IF-Lite 0.12.2](IF-Lite-0.12.2.jar) · [Upstream release](https://github.com/stefvanschie/IF/releases/tag/v0.12.2)

| Artifact | Bytes | SHA-256 |
| --- | ---: | --- |
| IF-Lite 0.12.2 | 296,304 | `d730e41a1728057aaf4e9fe9a772e09d54401cc4f80e10df6625007fbd3e4916` |
| Upstream IF 0.12.2 | 1,637,926 | `4af4d21cbbbe1ae97c700b2f7ab69b3c1301d0c719481080af829d342d5dcedd` |

## Build

With Maven 3.9 and JDK 17, run:

```sh
mvn clean verify
```

The build resolves the pinned IF artifact from Maven Central and writes `target/IF-Lite-0.12.2.jar`. The historical [extract.sh](extract.sh) targets IF 0.10.19.

## Verification

A test plugin running with the Lite JAR built a chest menu with two pages on Paper 1.21.11 build 132 and Paper 26.3 build 253. Both servers rendered the expected book and diamond items in their respective panes. On 1.21.11 a protocol client opened the menu, clicked the book and received the diamond on the second page. The 26.3 check covered server-side rendering only.

## PlayerChannels

PlayerChannels 3.8.2 uses [IF-Lite 0.11.6](https://github.com/maximus-f/IF-Lite/tree/codex/if-lite-0.11.6). A compile check against the 0.12.2 Lite JAR found API changes in the pane constructors and placement methods. Migration requires supplying pane positions as `Slot` arguments when attaching panes and updating paging calls for the 0.12 API.

[License](LICENSE)

## Maven Central publishing

The public artifact uses `io.github.maximus-f:if-lite:0.12.2`. Its standalone consumer POM is in `central/pom.xml`. The Java packages stay the same. From the repository root, build with the prerequisites above and prepare a signed bundle:

```sh
mvn clean verify
python3 central/bundle.py --signing-key YOUR_OPENPGP_FINGERPRINT
```

Upload the resulting `target/*-central.zip` in the [Central Publisher Portal](https://central.sonatype.com/publishing/deployments), review validation, and publish. The release signer must have a [discoverable public key](https://central.sonatype.org/publish/requirements/gpg/).

To rehearse dependency resolution before publishing, run `python3 central/bundle.py --stage /path/to/test-repository` after the build. This writes the binary, sources, Javadoc, consumer POM and checksums into a fresh version directory using Maven's repository layout.
