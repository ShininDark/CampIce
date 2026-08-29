sprite_index = sLunatic;
image_speed = 1; // 4-frame idle animation, loops automatically

interactRadius = 40;
shopOpen = false;
shopTab = "items"; // "items" or "upgrades"

axeUpgradeBought = false;
pickaxeUpgradeBought = false;
damageUpgradeBought = false;

faloBought = false;

wasDialogueActive = false;

if (variable_global_exists("pendingLoad") && is_struct(global.pendingLoad) && global.pendingLoad.active) {
    axeUpgradeBought = global.pendingLoad.axeUpgradeBought;
    pickaxeUpgradeBought = global.pendingLoad.pickaxeUpgradeBought;
    damageUpgradeBought = global.pendingLoad.damageUpgradeBought;
    faloBought = global.pendingLoad.faloBought;
}