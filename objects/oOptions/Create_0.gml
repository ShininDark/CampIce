if (!variable_global_exists("musicVolume")) { global.musicVolume = 0.7; }
if (!variable_global_exists("musicMuted")) { global.musicMuted = false; }
if (!variable_global_exists("optionsOpen")) { global.optionsOpen = false; }

justOpened = false;
backHovered = false;
resumeHovered = false;
saveExitHovered = false;
inGameMode = false;

controlsOpen = false;
controlsHovered = false;
controlsBackHovered = false;