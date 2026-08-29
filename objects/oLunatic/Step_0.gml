var inRange = instance_exists(oPlayer) && point_distance(x, y, oPlayer.x, oPlayer.y) < interactRadius;

var dialogueJustClosed = wasDialogueActive && !global.gamePaused;
wasDialogueActive = global.gamePaused;

if (inRange && keyboard_check_pressed(ord("E")) && !global.gamePaused && !dialogueJustClosed) {
    if (global.questStage == 0) {
        startDialogue([
            "Hey there, welcome to camp. You'll need to gather resources to survive out here.",
            "There are some things you need to keep in mind when going out in the open. Be very careful..",
            "Enemies will chase you and take away 10 cold from your cold meter for every hit they land on you. Left click to hit back the enemies. You can upgrade damage if you bring me an enemy shard.",
            "Ores and Trees can be mined. Press and hold left click near an ore or a tree to start mining. You will need those resources if you want to escape this place. You can purchase upgrades to be faster at mining if you bring me some items.",
            "You have an ability that can come in handy. Press Space Bar to place an anchor on ur cursor's position and press it again to pull nearby enemies and insta-kill them. Be mindful of when you use it! It has a 60 second cooldown",
            "Start by exploring the place.."
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