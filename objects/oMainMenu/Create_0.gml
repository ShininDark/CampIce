// Button hitboxes (top-left x/y, bottom-right x/y)
playX1 = 1225; playY1 = 598; playX2 = 1639; playY2 = 698;
loadX1 = 1225; loadY1 = 743; loadX2 = 1639; loadY2 = 843;
exitX1 = 1225; exitY1 = 888; exitX2 = 1639; exitY2 = 988;
settingsX1 = 1612; settingsY1 = 1088; settingsX2 = 1712; settingsY2 = 1164;

// Clean up gameplay UI so it doesn't linger on the main menu
if (instance_exists(oInventory)) instance_destroy(oInventory);
if (instance_exists(oHud)) instance_destroy(oHud);
if (instance_exists(oDialogue)) instance_destroy(oDialogue);
if (instance_exists(oCutscene)) instance_destroy(oCutscene);
    
if (!variable_global_exists("gamePaused")) {
    global.gamePaused = false;
}

loadAvailable = SaveGameExists();
menuNotice = "";
menuNoticeTimer = 0;