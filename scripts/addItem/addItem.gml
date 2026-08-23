function addItem(itemDef, amt) {
    var needAdded = amt;
    var arrays = [oInventory.hotbar, oInventory.inventory];

    if (itemDef.stacks) {
        for (var a = 0; a < 2; a++) {
            var arr = arrays[a];
            for (var i = 0; i < array_length(arr); i++) {
                if (arr[i] != noone && arr[i].itemId == itemDef.itemId) {
                    var canAdd = global.stackSize - arr[i].count;
                    if (canAdd <= 0) continue;
                    if (canAdd < needAdded) {
                        arr[i].count += canAdd;
                        needAdded -= canAdd;
                    } else {
                        arr[i].count += needAdded;
                        return true;
                    }
                }
            }
        }
    }

    for (var a = 0; a < 2; a++) {
        var arr = arrays[a];
        for (var i = 0; i < array_length(arr); i++) {
            if (arr[i] == noone) {
                var giveAmt = min(needAdded, global.stackSize);
                arr[i] = { itemId: itemDef.itemId, sprite: itemDef.sprite, count: giveAmt, sellValue: itemDef.sellValue };
                needAdded -= giveAmt;
                if (needAdded <= 0) return true;
            }
        }
    }

    show_debug_message("Inventory full!");
    return false;
}