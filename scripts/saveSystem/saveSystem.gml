#macro SAVE_FILE_NAME "campice_save.json"
#macro SAVE_FORMAT_VERSION 1

function SaveGameExists() {
    return file_exists(SAVE_FILE_NAME);
}

// Converts a hotbar/inventory array (noone or {itemId,sprite,count,sellValue}) into
// JSON-safe {itemId, count} pairs — sprite/sellValue are rebuilt from itemId on load.
function saveSlotsToSimple(slotArray) {
    var result = [];
    for (var i = 0; i < array_length(slotArray); i++) {
        var slot = slotArray[i];
        if (slot == noone) {
            array_push(result, { itemId: "", count: 0 });
        } else {
            array_push(result, { itemId: slot.itemId, count: slot.count });
        }
    }
    return result;
}

function saveSlotsFromSimple(simpleArray, slotCount) {
    var result = array_create(slotCount, noone);
    if (!is_array(simpleArray)) return result;
    
    var count = min(slotCount, array_length(simpleArray));
    for (var i = 0; i < count; i++) {
        var savedSlot = simpleArray[i];
        if (is_struct(savedSlot) && savedSlot.itemId != "" && savedSlot.count > 0) {
            var itemDef = getItemDef(savedSlot.itemId);
            if (itemDef != noone) {
                result[i] = {
                    itemId: itemDef.itemId,
                    sprite: itemDef.sprite,
                    count: savedSlot.count,
                    sellValue: itemDef.sellValue
                };
            }
        }
    }
    return result;
}

function SaveGameWrite() {
    if (room != rMain || !instance_exists(oPlayer) || !instance_exists(oInventory) || !instance_exists(oLunatic)) {
        show_debug_message("Save failed: can only save during gameplay.");
        return false;
    }
    
    var player = instance_find(oPlayer, 0);
    var inv = instance_find(oInventory, 0);
    var lunatic = instance_find(oLunatic, 0);
    
    var saveData = {
        saveVersion: SAVE_FORMAT_VERSION,
        harvestedNodeIds: global.harvestedNodeIds,
        
        player: {
            x: player.x,
            y: player.y,
            cold: player.cold,
            attackDamage: player.attackDamage
        },
        
        hotbar: saveSlotsToSimple(inv.hotbar),
        inventory: saveSlotsToSimple(inv.inventory),
        
        lunatic: {
            axeUpgradeBought: lunatic.axeUpgradeBought,
            pickaxeUpgradeBought: lunatic.pickaxeUpgradeBought,
            damageUpgradeBought: lunatic.damageUpgradeBought,
            faloBought: lunatic.faloBought
        },
        
        quest: {
            questStage: global.questStage,
            coldLampHeadsUpShown: global.coldLampHeadsUpShown,
            questOreCount: global.questOreCount,
            questLogCount: global.questLogCount,
            questKillCount: global.questKillCount,
            questUpgradesBought: global.questUpgradesBought
        }
    };
    
    var json = json_stringify(saveData);
    var file = file_text_open_write(SAVE_FILE_NAME);
    if (file < 0) {
        show_debug_message("Save failed: could not open save file.");
        return false;
    }
    file_text_write_string(file, json);
    file_text_close(file);
    
    show_debug_message("Game saved to " + SAVE_FILE_NAME);
    return true;
}

function SaveGameLoad() {
    
    if (!SaveGameExists()) {
        show_debug_message("Load failed: no save file exists.");
        return false;
    }
    
    var file = file_text_open_read(SAVE_FILE_NAME);
    if (file < 0) {
        show_debug_message("Load failed: could not open save file.");
        return false;
    }
    
    var json = "";
    while (!file_text_eof(file)) {
        json += file_text_read_string(file);
        file_text_readln(file);
    }
    file_text_close(file);
    
    var data = json_parse(json);
    
    if (!is_struct(data) || !struct_exists(data, "saveVersion") || data.saveVersion != SAVE_FORMAT_VERSION) {
        show_debug_message("Load failed: unsupported save version.");
        return false;
    }
    
    var q = data.quest;
    global.questStage = q.questStage;
    global.coldLampHeadsUpShown = q.coldLampHeadsUpShown;
    global.questOreCount = q.questOreCount;
    global.questLogCount = q.questLogCount;
    global.questKillCount = q.questKillCount;
    global.questUpgradesBought = q.questUpgradesBought;
    global.harvestedNodeIds = data.harvestedNodeIds;

    if (!is_array(global.harvestedNodeIds)) { global.harvestedNodeIds = []; }
    
    global.pendingLoad = {
        active: true,
        playerX: data.player.x,
        playerY: data.player.y,
        playerCold: data.player.cold,
        playerAttackDamage: data.player.attackDamage,
        hotbar: data.hotbar,
        inventory: data.inventory,
        axeUpgradeBought: data.lunatic.axeUpgradeBought,
        pickaxeUpgradeBought: data.lunatic.pickaxeUpgradeBought,
        damageUpgradeBought: data.lunatic.damageUpgradeBought,
        faloBought: data.lunatic.faloBought
    };
    
    room_goto(rMain);
    
    show_debug_message("Game loaded from " + SAVE_FILE_NAME);
    return true;
}