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