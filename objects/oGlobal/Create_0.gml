dt = 1; // safe default, immediately overwritten by Step each frame
global.gamePaused = false; // freezes player/enemy while dialogue or a cutscene is active

global.questStage = 0; // 0=talk to lunatic, 1=mine ore, 2=chop tree, 3=kill enemy, 100=parallel, 200=buy falo, 999=done
global.coldLampHeadsUpShown = false; // tracks the one-time cold lamp interrupt

// parallel phase counters (used once questStage == 100)
global.questOreCount = 0;
global.questOreTarget = 3;
global.questLogCount = 0;
global.questLogTarget = 3;
global.questKillCount = 0;
global.questKillTarget = 3;
global.questUpgradesBought = 0;
global.questUpgradesTarget = 3;