if (!global.optionsOpen) exit;

var guiW = display_get_gui_width();
var guiH = display_get_gui_height();

draw_set_alpha(0.55);
draw_rectangle_color(0, 0, guiW, guiH, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);

var panelW = 420;
var panelH = 320;
var panelX = (guiW/2) - (panelW/2);
var panelY = (guiH/2) - (panelH/2);

draw_rectangle_color(panelX, panelY, panelX + panelW, panelY + panelH, c_black, c_black, c_black, c_black, false);
draw_rectangle_color(panelX, panelY, panelX + panelW, panelY + panelH, c_white, c_white, c_white, c_white, true);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// --- Resume / Save & Exit buttons (gameplay mode only) ---
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

if (inGameMode) {
    var resumeColor = resumeHovered ? c_yellow : c_white;
    draw_set_color(resumeColor);
    draw_rectangle_color(resumeX1, resumeY1, resumeX2, resumeY2, resumeColor, resumeColor, resumeColor, resumeColor, true);
    draw_text((resumeX1+resumeX2)/2, (resumeY1+resumeY2)/2, "Resume");
    
    var saveExitColor = saveExitHovered ? c_yellow : c_white;
    draw_set_color(saveExitColor);
    draw_rectangle_color(saveExitX1, saveExitY1, saveExitX2, saveExitY2, saveExitColor, saveExitColor, saveExitColor, saveExitColor, true);
    draw_text((saveExitX1+saveExitX2)/2, (saveExitY1+saveExitY2)/2, "Save & Exit");
}

// --- Volume slider ---
draw_set_color(c_white);
var volumeLabel = global.musicMuted ? "Volume: Muted" : ("Volume: " + string(round(global.musicVolume * 100)) + "%");
var sliderX1 = panelX + 30;
var sliderX2 = panelX + panelW - 30;
var sliderY = inGameMode ? (saveExitY2 + 50) : (panelY + 100);

draw_text(panelX + panelW/2, sliderY - 30, volumeLabel);

draw_rectangle_color(sliderX1, sliderY - 4, sliderX2, sliderY + 4, c_gray, c_gray, c_gray, c_gray, false);
var knobX = lerp(sliderX1, sliderX2, global.musicMuted ? 0 : global.musicVolume);
draw_rectangle_color(sliderX1, sliderY - 4, knobX, sliderY + 4, c_white, c_white, c_white, c_white, false);
draw_circle_color(knobX, sliderY, 8, c_white, c_white, false);

draw_set_color(c_white);
draw_text(panelX + panelW/2, panelY + panelH - 20, inGameMode ? "Left/Right: Volume   M: Mute   Esc: Resume" : "Left/Right: Volume   M: Mute   Esc: Close");

draw_set_halign(fa_left);
draw_set_valign(fa_top);