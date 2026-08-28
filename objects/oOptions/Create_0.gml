if (!variable_global_exists("musicVolume")) { global.musicVolume = 0.7; }
if (!variable_global_exists("musicMuted")) { global.musicMuted = false; }
if (!variable_global_exists("optionsOpen")) { global.optionsOpen = false; }

justOpened = false;
backHovered = false;
resumeHovered = false;
saveExitHovered = false;
inGameMode = false; // true = opened during gameplay (Resume/Save&Exit shown), false = opened from main menu (volume only)