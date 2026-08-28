function getQuestHudText() {
    switch (global.questStage) {
        case 0: return "Talk to Lunatic";
        case 1: return "Mine an ore";
        case 2: return "Chop a tree";
        case 3: return "Kill an enemy";
        case 100:
            if (global.questOreCount < global.questOreTarget)
                return "Mine ore (" + string(global.questOreCount) + "/" + string(global.questOreTarget) + ")";
            if (global.questLogCount < global.questLogTarget)
                return "Chop logs (" + string(global.questLogCount) + "/" + string(global.questLogTarget) + ")";
            if (global.questKillCount < global.questKillTarget)
                return "Kill enemies (" + string(global.questKillCount) + "/" + string(global.questKillTarget) + ")";
            if (global.questUpgradesBought < global.questUpgradesTarget)
                return "Buy all upgrades (" + string(global.questUpgradesBought) + "/" + string(global.questUpgradesTarget) + ")";
            return "";
        case 200: return "Buy Falo from Lunatic";
        case 999: return "";
    }
    return "";
}