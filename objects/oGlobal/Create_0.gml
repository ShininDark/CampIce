dt = 1;
global.gamePaused = false;

if (!variable_global_exists("harvestedNodeIds")) { global.harvestedNodeIds = []; }
if (!variable_global_exists("pendingLoad")) { global.pendingLoad = noone; }

var isLoading = is_struct(global.pendingLoad) && global.pendingLoad.active;

if (!isLoading) {
    global.questStage = 0;
    global.coldLampHeadsUpShown = false;
    global.questOreCount = 0;
    global.questOreTarget = 3;
    global.questLogCount = 0;
    global.questLogTarget = 3;
    global.questKillCount = 0;
    global.questKillTarget = 3;
    global.questUpgradesBought = 0;
    global.questUpgradesTarget = 3;
}

if (!variable_global_exists("touchMoveX")) { global.touchMoveX = 0; }
if (!variable_global_exists("touchMoveY")) { global.touchMoveY = 0; }
if (!variable_global_exists("touchAttackPressed")) { global.touchAttackPressed = false; }
if (!variable_global_exists("touchInteractHeld")) { global.touchInteractHeld = false; }
if (!variable_global_exists("touchInteractPressed")) { global.touchInteractPressed = false; }
if (!variable_global_exists("touchInventoryPressed")) { global.touchInventoryPressed = false; }
if (!variable_global_exists("touchAnchorPressed")) { global.touchAnchorPressed = false; }
if (!variable_global_exists("touchPausePressed")) { global.touchPausePressed  = false; }
