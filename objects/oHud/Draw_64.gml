// --- Quest tracker with completion animation ---
var boxX = 20;
var boxY = 20;
var boxW = 220;
var boxH = 40;

if (questState == "showingComplete") {
    draw_rectangle_color(boxX, boxY, boxX + boxW, boxY + boxH, c_black, c_black, c_black, c_black, false);
    draw_rectangle_color(boxX, boxY, boxX + boxW, boxY + boxH, c_lime, c_lime, c_lime, c_lime, true);
    
    draw_set_color(c_lime);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(boxX + boxW/2, boxY + boxH/2, "Quest Complete!");
}
else if (questDisplayText != "") {
    var slideOffset = 0;
    
    if (questState == "slidingIn") {
        var slidePct = questSlideTimer / questSlideDuration;
        slideOffset = (1 - slidePct) * -boxW;
    }
    
    draw_rectangle_color(boxX + slideOffset, boxY, boxX + slideOffset + boxW, boxY + boxH, c_black, c_black, c_black, c_black, false);
    draw_rectangle_color(boxX + slideOffset, boxY, boxX + slideOffset + boxW, boxY + boxH, c_white, c_white, c_white, c_white, true);
    
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    draw_text_ext(boxX + slideOffset + 12, boxY + boxH/2, "Quest: " + questDisplayText, -1, boxW - 24);
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);

// --- Cold vignette ---
var guiW = display_get_gui_width();
var guiH = display_get_gui_height();

if (instance_exists(oPlayer)) {
    var coldPct = clamp(oPlayer.cold / oPlayer.coldMax, 0, 1);
    
    var dangerStart = 0.5;
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

// --- Cold meter bar ---
var barWidth = 200;
var barHeight = 20;
var barX = (guiW / 2) - (barWidth / 2);
var barY = 20;
draw_rectangle_color(barX, barY, barX + barWidth, barY + barHeight, c_black, c_black, c_black, c_black, false);
var coldBarPct = oPlayer.cold / oPlayer.coldMax;
draw_rectangle_color(barX, barY, barX + (barWidth * coldBarPct), barY + barHeight, c_blue, c_aqua, c_blue, c_aqua, false);
var labelText = string(round(oPlayer.cold)) + "/" + string(oPlayer.coldMax);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(barX + (barWidth / 2), barY + (barHeight / 2), labelText);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// --- Death screen ---
if (instance_exists(oPlayer) && oPlayer.isDead) {
    draw_set_alpha(0.6);
    draw_rectangle_color(0, 0, guiW, guiH, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text(guiW / 2, guiH / 2 - 50, "You Died");
    
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

// --- Fade to black on restart ---
if (fadeState == "fadingOut") {
    draw_set_alpha(fadeAlpha);
    draw_rectangle_color(0, 0, guiW, guiH, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
}