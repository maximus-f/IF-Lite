#!/bin/bash

###############################################################################
# DEBUG SETTINGS
###############################################################################
# -e  : exit immediately if a command exits with a nonzero status
# -x  : print each command as it runs (for debugging)
set -e
set -x

###############################################################################
# 1) Sanity Check: JAR file
###############################################################################
if [ ! -f "libs/IF-0.10.19.jar" ]; then
  echo "Error: IF-0.10.19.jar not found in libs directory"
  exit 1
fi

###############################################################################
# 2) Extract Original JAR
###############################################################################
mkdir -p temp
cd temp
jar xf ../libs/IF-0.10.19.jar

# Debug: list extracted Pane-related classes
echo "DEBUG: Checking for Pane classes after extraction:"
find com/github/stefvanschie/inventoryframework/pane -name "Pane*.class" 2>/dev/null || echo "No Pane*.class files found"

###############################################################################
# 3) Create Output Structure
###############################################################################
mkdir -p ../mini-jar/com/github/stefvanschie/inventoryframework/{gui,pane,util,adventuresupport,exception,gui/type,gui/type/util,pane/util,inventoryview,inventoryview/abstraction,inventoryview/interface_,inventoryview/abstractclass}

###############################################################################
# 4) Copy Only the Required Classes
###############################################################################
# 4A) Main Classes
cp -v com/github/stefvanschie/inventoryframework/gui/GuiItem.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/
cp -v com/github/stefvanschie/inventoryframework/gui/type/ChestGui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/
cp -v com/github/stefvanschie/inventoryframework/gui/type/util/Gui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/util/
cp -v com/github/stefvanschie/inventoryframework/pane/StaticPane.class ../mini-jar/com/github/stefvanschie/inventoryframework/pane/
cp -v com/github/stefvanschie/inventoryframework/pane/PaginatedPane.class ../mini-jar/com/github/stefvanschie/inventoryframework/pane/
cp -v com/github/stefvanschie/inventoryframework/pane/Pane.class ../mini-jar/com/github/stefvanschie/inventoryframework/pane/
# 4B) Core dependencies
cp -v com/github/stefvanschie/inventoryframework/gui/InventoryComponent.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/
cp -v com/github/stefvanschie/inventoryframework/HumanEntityCache.class ../mini-jar/com/github/stefvanschie/inventoryframework/
cp -v com/github/stefvanschie/inventoryframework/gui/GuiListener.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/

# 4C) Helper classes
cp -v com/github/stefvanschie/inventoryframework/gui/type/util/InventoryBased.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/util/
cp -v com/github/stefvanschie/inventoryframework/gui/type/util/NamedGui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/util/
cp -v com/github/stefvanschie/inventoryframework/gui/type/util/Gui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/util/
cp -v com/github/stefvanschie/inventoryframework/gui/type/util/MergedGui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/util/
cp -v com/github/stefvanschie/inventoryframework/pane/util/Slot.class ../mini-jar/com/github/stefvanschie/inventoryframework/pane/util/
cp -v com/github/stefvanschie/inventoryframework/pane/Flippable.class ../mini-jar/com/github/stefvanschie/inventoryframework/pane/
cp -v com/github/stefvanschie/inventoryframework/pane/Rotatable.class ../mini-jar/com/github/stefvanschie/inventoryframework/pane/
cp -v com/github/stefvanschie/inventoryframework/pane/OutlinePane.class ../mini-jar/com/github/stefvanschie/inventoryframework/pane/
cp -v com/github/stefvanschie/inventoryframework/pane/Orientable.class ../mini-jar/com/github/stefvanschie/inventoryframework/pane/
cp -v com/github/stefvanschie/inventoryframework/pane/util/Mask.class ../mini-jar/com/github/stefvanschie/inventoryframework/pane/util/

# Additional pane types from the registration section
mkdir -p ../mini-jar/com/github/stefvanschie/inventoryframework/pane/component
mkdir -p ../mini-jar/com/github/stefvanschie/inventoryframework/pane/component/util
# cp -v com/github/stefvanschie/inventoryframework/pane/component/*\$*.class ../mini-jar/com/github/stefvanschie/inventoryframework/pane/component/

cp -v com/github/stefvanschie/inventoryframework/pane/MasonryPane.class ../mini-jar/com/github/stefvanschie/inventoryframework/pane/
cp -v com/github/stefvanschie/inventoryframework/pane/PatternPane.class ../mini-jar/com/github/stefvanschie/inventoryframework/pane/
cp -v com/github/stefvanschie/inventoryframework/pane/component/CycleButton.class ../mini-jar/com/github/stefvanschie/inventoryframework/pane/component/
cp -v com/github/stefvanschie/inventoryframework/pane/component/Label.class ../mini-jar/com/github/stefvanschie/inventoryframework/pane/component/
cp -v com/github/stefvanschie/inventoryframework/pane/component/PagingButtons.class ../mini-jar/com/github/stefvanschie/inventoryframework/pane/component/
cp -v com/github/stefvanschie/inventoryframework/pane/component/PercentageBar.class ../mini-jar/com/github/stefvanschie/inventoryframework/pane/component/
cp -v com/github/stefvanschie/inventoryframework/pane/component/Slider.class ../mini-jar/com/github/stefvanschie/inventoryframework/pane/component/
cp -v com/github/stefvanschie/inventoryframework/pane/component/ToggleButton.class ../mini-jar/com/github/stefvanschie/inventoryframework/pane/component/
cp -v com/github/stefvanschie/inventoryframework/pane/component/util/VariableBar.class ../mini-jar/com/github/stefvanschie/inventoryframework/pane/component/util/
# Additional GUI types from the registration section
cp -v com/github/stefvanschie/inventoryframework/gui/type/AnvilGui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/
cp -v com/github/stefvanschie/inventoryframework/gui/type/BarrelGui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/
cp -v com/github/stefvanschie/inventoryframework/gui/type/BeaconGui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/
cp -v com/github/stefvanschie/inventoryframework/gui/type/BlastFurnaceGui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/
cp -v com/github/stefvanschie/inventoryframework/gui/type/BrewingStandGui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/
cp -v com/github/stefvanschie/inventoryframework/gui/type/CartographyTableGui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/
cp -v com/github/stefvanschie/inventoryframework/gui/type/CraftingTableGui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/
cp -v com/github/stefvanschie/inventoryframework/gui/type/DispenserGui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/
cp -v com/github/stefvanschie/inventoryframework/gui/type/DropperGui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/
cp -v com/github/stefvanschie/inventoryframework/gui/type/EnchantingTableGui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/
cp -v com/github/stefvanschie/inventoryframework/gui/type/EnderChestGui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/
cp -v com/github/stefvanschie/inventoryframework/gui/type/FurnaceGui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/
#cp -v com/github/stefvanschie/inventoryframework/gui/type/GrindstoneGui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/
cp -v com/github/stefvanschie/inventoryframework/gui/type/HopperGui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/
cp -v com/github/stefvanschie/inventoryframework/gui/type/MerchantGui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/
cp -v com/github/stefvanschie/inventoryframework/gui/type/ModernSmithingTableGui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/
cp -v com/github/stefvanschie/inventoryframework/gui/type/ShulkerBoxGui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/
cp -v com/github/stefvanschie/inventoryframework/gui/type/SmithingTableGui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/
cp -v com/github/stefvanschie/inventoryframework/gui/type/SmokerGui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/
cp -v com/github/stefvanschie/inventoryframework/gui/type/StonecutterGui.class ../mini-jar/com/github/stefvanschie/inventoryframework/gui/type/

# 4D) Utility classes
mkdir -p ../mini-jar/com/github/stefvanschie/inventoryframework/util
cp -v com/github/stefvanschie/inventoryframework/util/*.class ../mini-jar/com/github/stefvanschie/inventoryframework/util/
mkdir -p ../mini-jar/com/github/stefvanschie/inventoryframework/util/version
cp -v com/github/stefvanschie/inventoryframework/util/version/Version.class ../mini-jar/com/github/stefvanschie/inventoryframework/util/version/


# 4E) Adventure support
mkdir -p ../mini-jar/com/github/stefvanschie/inventoryframework/adventuresupport
cp -v com/github/stefvanschie/inventoryframework/adventuresupport/*.class ../mini-jar/com/github/stefvanschie/inventoryframework/adventuresupport/

# 4F) Exception classes
mkdir -p ../mini-jar/com/github/stefvanschie/inventoryframework/exception
cp -v com/github/stefvanschie/inventoryframework/exception/*.class ../mini-jar/com/github/stefvanschie/inventoryframework/exception/

# 4G) InventoryView abstraction (minimized, no NMS)
echo "DEBUG: Copying InventoryView abstraction classes..."
cp -v com/github/stefvanschie/inventoryframework/inventoryview/abstraction/AbstractInventoryViewUtil.class ../mini-jar/com/github/stefvanschie/inventoryframework/inventoryview/abstraction/ 2>/dev/null || echo "No AbstractInventoryViewUtil.class found"

cp -v com/github/stefvanschie/inventoryframework/inventoryview/interface_/InventoryViewUtil.class ../mini-jar/com/github/stefvanschie/inventoryframework/inventoryview/interface_/ 2>/dev/null || echo "No interface_ InventoryViewUtil.class found"

cp -v com/github/stefvanschie/inventoryframework/inventoryview/abstractclass/InventoryViewUtil.class ../mini-jar/com/github/stefvanschie/inventoryframework/inventoryview/abstractclass/ 2>/dev/null || echo "No abstractclass InventoryViewUtil.class found"

# Create a simplified version of any missing implementation classes to avoid NMS dependencies
mkdir -p ../src-gen/com/github/stefvanschie/inventoryframework/inventoryview/abstraction
mkdir -p ../src-gen/com/github/stefvanschie/inventoryframework/inventoryview/interface_
mkdir -p ../src-gen/com/github/stefvanschie/inventoryframework/inventoryview/abstractclass

# 4H) Inner classes
cp -v com/github/stefvanschie/inventoryframework/pane/Pane\$*.class ../mini-jar/com/github/stefvanschie/inventoryframework/pane/
cp -v com/github/stefvanschie/inventoryframework/pane/util/Slot\$*.class ../mini-jar/com/github/stefvanschie/inventoryframework/pane/util
cp -v com/github/stefvanschie/inventoryframework/pane/OutlinePane\$*.class ../mini-jar/com/github/stefvanschie/inventoryframework/pane/
cp -v com/github/stefvanschie/inventoryframework/pane/Orientable\$*.class ../mini-jar/com/github/stefvanschie/inventoryframework/pane/

###############################################################################
# 5) Create Simplified Implementation Classes If Missing
###############################################################################
if [ ! -f "../mini-jar/com/github/stefvanschie/inventoryframework/inventoryview/interface_/InventoryViewUtil.class" ]; then
  echo "Creating simplified implementation for interface_ InventoryViewUtil..."
  cat > ../src-gen/com/github/stefvanschie/inventoryframework/inventoryview/interface_/InventoryViewUtil.java << 'EOF'
package com.github.stefvanschie.inventoryframework.inventoryview.interface_;

import com.github.stefvanschie.inventoryframework.inventoryview.abstraction.AbstractInventoryViewUtil;
import org.bukkit.event.inventory.InventoryType;
import org.bukkit.inventory.Inventory;
import org.bukkit.inventory.InventoryView;
import org.bukkit.inventory.ItemStack;
import org.jetbrains.annotations.Contract;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

public class InventoryViewUtil implements AbstractInventoryViewUtil {
    private static final InventoryViewUtil INSTANCE = new InventoryViewUtil();

    private InventoryViewUtil() {}

    @NotNull
    public static InventoryViewUtil getInstance() {
        return INSTANCE;
    }

    @Override
    @NotNull
    public Inventory getBottomInventory(@NotNull InventoryView view) {
        return view.getBottomInventory();
    }

    @Override
    @NotNull
    public ItemStack getCursor(@NotNull InventoryView view) {
        return view.getCursor();
    }

    @Override
    public void setCursor(@NotNull InventoryView view, @Nullable ItemStack itemStack) {
        view.setCursor(itemStack);
    }

    @Override
    @Nullable
    public Inventory getInventory(@NotNull InventoryView view, int rawSlot) {
        if (rawSlot < 0) {
            return null;
        }
        
        if (rawSlot < view.getTopInventory().getSize()) {
            return view.getTopInventory();
        } else if (rawSlot < view.countSlots()) {
            return view.getBottomInventory();
        } else {
            return null;
        }
    }

    @Override
    @Nullable
    public InventoryType.SlotType getSlotType(@NotNull InventoryView view, int rawSlot) {
        return view.getSlotType(rawSlot);
    }

    @Override
    @NotNull
    public String getTitle(@NotNull InventoryView view) {
        return view.getTitle();
    }

    @Override
    @NotNull
    public Inventory getTopInventory(@NotNull InventoryView view) {
        return view.getTopInventory();
    }
}
EOF

  mkdir -p ../classes/com/github/stefvanschie/inventoryframework/inventoryview/interface_
  javac -cp libs/IF-0.10.19.jar -d ../classes ../src-gen/com/github/stefvanschie/inventoryframework/inventoryview/interface_/InventoryViewUtil.java 2>/dev/null || echo "Failed to compile interface_ implementation"
  cp -v ../classes/com/github/stefvanschie/inventoryframework/inventoryview/interface_/InventoryViewUtil.class ../mini-jar/com/github/stefvanschie/inventoryframework/inventoryview/interface_/ 2>/dev/null || echo "Failed to copy compiled interface_ implementation"
fi

if [ ! -f "../mini-jar/com/github/stefvanschie/inventoryframework/inventoryview/abstractclass/InventoryViewUtil.class" ]; then
  echo "Creating simplified implementation for abstractclass InventoryViewUtil..."
  cat > ../src-gen/com/github/stefvanschie/inventoryframework/inventoryview/abstractclass/InventoryViewUtil.java << 'EOF'
package com.github.stefvanschie.inventoryframework.inventoryview.abstractclass;

import com.github.stefvanschie.inventoryframework.inventoryview.abstraction.AbstractInventoryViewUtil;
import org.bukkit.event.inventory.InventoryType;
import org.bukkit.inventory.Inventory;
import org.bukkit.inventory.InventoryView;
import org.bukkit.inventory.ItemStack;
import org.jetbrains.annotations.Contract;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

public class InventoryViewUtil implements AbstractInventoryViewUtil {
    private static final InventoryViewUtil INSTANCE = new InventoryViewUtil();

    private InventoryViewUtil() {}

    @NotNull
    public static InventoryViewUtil getInstance() {
        return INSTANCE;
    }

    @Override
    @NotNull
    public Inventory getBottomInventory(@NotNull InventoryView view) {
        return view.getBottomInventory();
    }

    @Override
    @NotNull
    public ItemStack getCursor(@NotNull InventoryView view) {
        return view.getCursor();
    }

    @Override
    public void setCursor(@NotNull InventoryView view, @Nullable ItemStack itemStack) {
        view.setCursor(itemStack);
    }

    @Override
    @Nullable
    public Inventory getInventory(@NotNull InventoryView view, int rawSlot) {
        if (rawSlot < 0) {
            return null;
        }
        
        if (rawSlot < view.getTopInventory().getSize()) {
            return view.getTopInventory();
        } else if (rawSlot < view.countSlots()) {
            return view.getBottomInventory();
        } else {
            return null;
        }
    }

    @Override
    @Nullable
    public InventoryType.SlotType getSlotType(@NotNull InventoryView view, int rawSlot) {
        return view.getSlotType(rawSlot);
    }

    @Override
    @NotNull
    public String getTitle(@NotNull InventoryView view) {
        return view.getTitle();
    }

    @Override
    @NotNull
    public Inventory getTopInventory(@NotNull InventoryView view) {
        return view.getTopInventory();
    }
}
EOF

  mkdir -p ../classes/com/github/stefvanschie/inventoryframework/inventoryview/abstractclass
  javac -cp libs/IF-0.10.19.jar -d ../classes ../src-gen/com/github/stefvanschie/inventoryframework/inventoryview/abstractclass/InventoryViewUtil.java 2>/dev/null || echo "Failed to compile abstractclass implementation"
  cp -v ../classes/com/github/stefvanschie/inventoryframework/inventoryview/abstractclass/InventoryViewUtil.class ../mini-jar/com/github/stefvanschie/inventoryframework/inventoryview/abstractclass/ 2>/dev/null || echo "Failed to copy compiled abstractclass implementation"
fi

###############################################################################
# 6) Copy META-INF
###############################################################################
mkdir -p ../mini-jar/META-INF
cp -r META-INF/* ../mini-jar/META-INF/

###############################################################################
# 7) Debug: List Files Copied to mini-jar
###############################################################################
echo "DEBUG: Listing mini-jar/com/github/stefvanschie/inventoryframework/pane after copy..."
ls -R ../mini-jar/com/github/stefvanschie/inventoryframework/pane

echo "DEBUG: Listing mini-jar/com/github/stefvanschie/inventoryframework/inventoryview after copy..."
ls -R ../mini-jar/com/github/stefvanschie/inventoryframework/inventoryview 2>/dev/null || echo "No inventoryview directory found"

###############################################################################
# 8) Create the New Smaller JAR
###############################################################################
cd ../mini-jar
jar cf ../IF-Lite-0.10.19.jar .

# Debug: Check final JAR contents
cd ..
echo "DEBUG: Checking final IF-Lite-0.10.19.jar for Pane classes..."
jar tf IF-Lite-0.10.19.jar | grep "Pane" || echo "No Pane classes found in final JAR!"
jar tf IF-Lite-0.10.19.jar | grep "Gui" || echo "No Gui classes found in final JAR!"
echo "DEBUG: Checking final IF-Lite-0.10.19.jar for Orientable classes..."
jar tf IF-Lite-0.10.19.jar | grep "Orientable" || echo "No Orientable classes found in final JAR!"
echo "DEBUG: Checking final IF-Lite-0.10.19.jar for AbstractInventoryViewUtil..."
jar tf IF-Lite-0.10.19.jar | grep -i "InventoryView" || echo "No InventoryView classes found in final JAR!"

###############################################################################
# 9) Clean Up
###############################################################################
rm -rf temp mini-jar classes src-gen

###############################################################################
# 10) Summary
###############################################################################
echo "Created IF-Lite-0.10.19.jar with only the required classes"
echo "Original JAR size:"
ls -lh libs/IF-0.10.19.jar | awk '{print $5}'
echo "New JAR size:"
ls -lh IF-Lite-0.10.19.jar | awk '{print $5}'
