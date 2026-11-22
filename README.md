# IF-Lite for PlayerChannels

This standalone Maven project packages the parts of InventoryFramework used by PlayerChannels' chest menus, menu clicks and paginated inventories. The build extracts unmodified shared classes from the published upstream JAR, including the inventory-view implementations used before and after Bukkit changed InventoryView to an interface. Specialized inventories that require Minecraft server internals and bundled font resources are outside the scope of this distribution.

[Download IF-Lite 0.11.6](IF-Lite-0.11.6.jar) · SHA-256 `81847ebb076d29003a127d9b7a179e88a4ae63197105506b271d2fd3bbe43fb1`

The original [extract.sh](extract.sh) targets IF 0.10.19. Use the Maven build below for 0.11.6.

## Build

Use Maven 3.9 and JDK 17. From this directory run:

```sh
mvn clean verify
```

The output is `target/IF-Lite-0.11.6.jar`. Maven resolves upstream IF from Central at build time. Consuming the Lite artifact does not pull the full IF dependency. To update PlayerChannels, copy the built JAR and this POM into the matching version directory under its `vendor/maven`, refresh the SHA-1 and SHA-256 sidecars, and set the IF-Lite version in PlayerChannels' POM. Keep the package relocation in PlayerChannels' shade configuration.

For an upgrade, select the upstream release in this POM, build from a clean target, and run PlayerChannels' menus on each target server version. InventoryFramework's own version detection is preserved.

## Verified integration

On November 21, 2026, PlayerChannels 3.8.2 built from an empty Maven cache with this library and ToastAPI 2.0. The 283,141-byte Lite JAR contains 93 unchanged upstream classes. The 886,892-byte shaded PlayerChannels JAR ran on Paper 1.21.11 build 132 with Java 21. Three test clients exercised channel creation, invitations, joining and leaving, member-only chat delivery, a chest menu click and receipt of the tutorial toast packet.

[Upstream IF 0.11.6](https://github.com/stefvanschie/IF/releases/tag/v0.11.6) · [License](LICENSE)
