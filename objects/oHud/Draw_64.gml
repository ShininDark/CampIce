var questText = getQuestHudText();
if (questText != "") {
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text(20, 20, "Quest: " + questText);
}

var guiW = display_get_gui_width();
var guiH = display_get_gui_height();

if (instance_exists(oPlayer)) {
    var coldPct = clamp(oPlayer.cold / oPlayer.coldMax, 0, 1);
    
    var dangerStart = 0.5; // vignette starts appearing once cold drops below this
    var vignetteAlpha = 0;
    
    if (coldPct < dangerStart) {
        vignetteAlpha = 1 - (coldPct / dangerStart);
    }
    
    if (vignetteAlpha > 0) {
        draw_set_alpha(vignetteAlpha);
        draw_sprite_stretched(sVignette, 0, 0, 0, guiW, guiH);
        draw_set_alpha(1);
    }
}

var guiWidth = display_get_gui_width();
var barWidth = 200;
var barHeight = 20;
var barX = (guiWidth / 2) - (barWidth / 2);
var barY = 20;
draw_rectangle_color(barX, barY, barX + barWidth, barY + barHeight, c_black, c_black, c_black, c_black, false);
var coldPct = oPlayer.cold / oPlayer.coldMax;
draw_rectangle_color(barX, barY, barX + (barWidth * coldPct), barY + barHeight, c_blue, c_aqua, c_blue, c_aqua, false);
var labelText = string(round(oPlayer.cold)) + "/" + string(oPlayer.coldMax);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(barX + (barWidth / 2), barY + (barHeight / 2), labelText);
draw_set_halign(fa_left);
draw_set_valign(fa_top);


if (instance_exists(oPlayer) && oPlayer.isDead) {
    var guiW = display_get_gui_width();
    var guiH = display_get_gui_height();
    
    // faded overlay, not solid black
    draw_set_alpha(0.6);
    draw_rectangle_color(0, 0, guiW, guiH, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text(guiW / 2, guiH / 2 - 50, "You Died");
    
    // restart button — only interactive while not already fading
    var btnW = 160;
    var btnH = 40;
    var btnX = (guiW / 2) - (btnW / 2);
    var btnY = guiH / 2;
    
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    var hovered = (fadeState == "none") && point_in_rectangle(mx, my, btnX, btnY, btnX + btnW, btnY + btnH);
    
    var btnColor = hovered ? c_dkgray : c_gray;
    draw_rectangle_color(btnX, btnY, btnX + btnW, btnY + btnH, btnColor, btnColor, btnColor, btnColor, false);
    draw_rectangle_color(btnX, btnY, btnX + btnW, btnY + btnH, c_white, c_white, c_white, c_white, true);
    draw_set_color(c_white);
    draw_text(btnX + btnW/2, btnY + btnH/2, "Restart");
    
    if (hovered && mouse_check_button_pressed(mb_left)) {
        fadeState = "fadingOut";
    }
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// fade-to-black overlay, drawn on top of everything (including the death screen above)
if (fadeState == "fadingOut") {
    draw_set_alpha(fadeAlpha);
    draw_rectangle_color(0, 0, guiW, guiH, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
}



