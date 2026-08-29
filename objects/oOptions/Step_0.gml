var inventoryOpen = instance_exists(oInventory) && oInventory.invOpen;
var shopOpen = instance_exists(oLunatic) && oLunatic.shopOpen;

if (!global.optionsOpen) {
    if (room == rMain && keyboard_check_pressed(vk_escape) && !global.gamePaused && !inventoryOpen && !shopOpen) {
        openOptionsPanel(true);
    }
    exit;
}

if (justOpened) {
    justOpened = false;
    exit;
}

var guiW = display_get_gui_width();
var guiH = display_get_gui_height();

var panelW = 420;
var panelH = 320;
var panelX = (guiW/2) - (panelW/2);
var panelY = (guiH/2) - (panelH/2);

// --- Resume / Save & Exit buttons ---
var btnW = 200;
var btnH = 40;
var resumeX1 = panelX + (panelW/2) - (btnW/2);
var resumeY1 = panelY + 40;
var resumeX2 = resumeX1 + btnW;
var resumeY2 = resumeY1 + btnH;

var saveExitX1 = resumeX1;
var saveExitY1 = resumeY1 + 55;
var saveExitX2 = resumeX2;
var saveExitY2 = saveExitY1 + btnH;

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

if (inGameMode) {
    resumeHovered = point_in_rectangle(mx, my, resumeX1, resumeY1, resumeX2, resumeY2);
    saveExitHovered = point_in_rectangle(mx, my, saveExitX1, saveExitY1, saveExitX2, saveExitY2);
    
    if (resumeHovered && mouse_check_button_pressed(mb_left)) {
        playSfx(sndButtonClick);
        closeOptionsPanel();
    }
    
    if (saveExitHovered && mouse_check_button_pressed(mb_left)) {
        playSfx(sndButtonClick);
        show_debug_message("Save & Exit clicked — not implemented yet");
    }
} else {
    resumeHovered = false;
    saveExitHovered = false;
}

// --- Volume slider ---
var sliderX1 = panelX + 30;
var sliderX2 = panelX + panelW - 30;
var sliderY = inGameMode ? (saveExitY2 + 50) : (panelY + 100);
var sliderTouchPad = 10;

if (mouse_check_button(mb_left) && point_in_rectangle(mx, my, sliderX1, sliderY - sliderTouchPad, sliderX2, sliderY + sliderTouchPad)) {
    global.musicVolume = clamp((mx - sliderX1) / (sliderX2 - sliderX1), 0, 1);
    global.musicMuted = false;
    if (variable_global_exists("currentMusicId") && audio_is_playing(global.currentMusicId)) {
        audio_sound_gain(global.currentMusicId, global.musicMuted ? 0 : global.musicVolume, 100);
    }
}

if (keyboard_check_pressed(vk_left)) {
    global.musicVolume = max(0, global.musicVolume - 0.1);
    global.musicMuted = false;
    if (variable_global_exists("currentMusicId") && audio_is_playing(global.currentMusicId)) {
        audio_sound_gain(global.currentMusicId, global.musicVolume, 100);
    }
}
if (keyboard_check_pressed(vk_right)) {
    global.musicVolume = min(1, global.musicVolume + 0.1);
    global.musicMuted = false;
    if (variable_global_exists("currentMusicId") && audio_is_playing(global.currentMusicId)) {
        audio_sound_gain(global.currentMusicId, global.musicVolume, 100);
    }
}
if (keyboard_check_pressed(ord("M"))) {
    global.musicMuted = !global.musicMuted;
    if (variable_global_exists("currentMusicId") && audio_is_playing(global.currentMusicId)) {
        audio_sound_gain(global.currentMusicId, global.musicMuted ? 0 : global.musicVolume, 100);
    }
}

if (keyboard_check_pressed(vk_escape)) {
    closeOptionsPanel();
}