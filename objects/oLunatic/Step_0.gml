var inRange = instance_exists(oPlayer) && point_distance(x, y, oPlayer.x, oPlayer.y) < interactRadius;

if (inRange && keyboard_check_pressed(ord("E")) && !global.gamePaused) {
    if (global.questStage == 0) {
        startDialogue([
            "Hey there, welcome to camp.",
            "You'll need to gather resources to survive out here.",
            "Start by mining an ore nearby."
        ], function() {
            global.questStage = 1;
        });
    } else {
        shopOpen = !shopOpen;
    }
}

if (!inRange && shopOpen) {
    shopOpen = false; // walking away closes the shop
}

if (global.questStage == 100 &&
    global.questOreCount >= global.questOreTarget &&
    global.questLogCount >= global.questLogTarget &&
    global.questKillCount >= global.questKillTarget &&
    global.questUpgradesBought >= global.questUpgradesTarget) {
    global.questStage = 200;
}