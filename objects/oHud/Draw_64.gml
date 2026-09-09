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
var baseBarWidth = 200;
var baseBarHeight = 20;

// Heartbeat pulse: two quick beats then a rest, like a real pulse
var beatPeriod = 1.0; // seconds per full beat cycle
var beatPhase = (heartbeatTimer mod beatPeriod) / beatPeriod;
var pulse = 0;
if (heartbeatTimer > 0) {
    var lub = max(0, sin(beatPhase * pi * 6)) * (beatPhase < 0.35);
    pulse = lub * 0.08; // max 8% size increase
}

var popScale = 0;
if (barPopTimer > 0) {
    var popT = barPopTimer / barPopDuration;
    popScale = sin(popT * pi) * 0.15; // quick punch up to 15%, then back down
}

var barWidth = baseBarWidth * (1 + pulse + popScale);
var barHeight = baseBarHeight * (1 + pulse + popScale);

var barX = (guiW / 2) - (barWidth / 2);
var barY = 20 - (barHeight - baseBarHeight) / 2;

draw_rectangle_color(barX, barY, barX + barWidth, barY + barHeight, c_black, c_black, c_black, c_black, false);
var coldBarPct = oPlayer.cold / oPlayer.coldMax;
var pulseColor = pulse > 0.02 ? c_red : c_aqua;
draw_rectangle_color(barX, barY, barX + (barWidth * coldBarPct), barY + barHeight, c_blue, pulseColor, c_blue, pulseColor, false);

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