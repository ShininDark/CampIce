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

// --- Cold meter ---
var baseBarWidth = 220;
var baseBarHeight = 26;

// Heartbeat pulse
var beatPeriod = 1.0;
var beatPhase = (heartbeatTimer mod beatPeriod) / beatPeriod;
var pulse = 0;
if (heartbeatTimer > 0) {
    var lub = max(0, sin(beatPhase * pi * 6)) * (beatPhase < 0.35);
    pulse = lub * 0.08;
}

var popScale = 0;
if (barPopTimer > 0) {
    var popT = barPopTimer / barPopDuration;
    popScale = sin(popT * pi) * 0.15;
}

var barWidth = baseBarWidth * (1 + pulse + popScale);
var barHeight = baseBarHeight * (1 + pulse + popScale);
var barX = (guiW / 2) - (barWidth / 2);
var barY = 22 - (barHeight - baseBarHeight) / 2;

var coldBarPct = clamp(oPlayer.cold / oPlayer.coldMax, 0, 1);
var isCritical = (oPlayer.cold / oPlayer.coldMax) < 0.3;

// Blend toward red as cold drops below the critical threshold, without losing the blue entirely
var dangerBlend = isCritical ? clamp(1 - (coldBarPct / 0.3), 0, 1) : 0;

// Label
draw_set_font(-1); // ensure default font, then simulate bold via double-draw
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_text(barX + barWidth/2 + 1, barY, "COLD");
draw_text(barX + barWidth/2 - 1, barY, "COLD"); // cheap bold effect without a bold font asset
draw_text(barX + barWidth/2, barY, "COLD");

// Drop shadow
draw_set_alpha(0.35);
draw_roundrect_color(barX - 2, barY + 3, barX + barWidth + 2, barY + barHeight + 5, c_black, c_black, false);
draw_set_alpha(1);

// Outer frame — thin ring, filled shape with the trough drawn inset on top
var frameColor = merge_color(c_white, c_red, dangerBlend);
var frameThickness = 1.5;
draw_roundrect_color(barX - frameThickness, barY - frameThickness, barX + barWidth + frameThickness, barY + barHeight + frameThickness, frameColor, frameColor, false);

// Trough (empty background) — drawn on top of the frame, inset by frameThickness, leaving a thin visible ring
var troughColor = make_color_rgb(18, 28, 46);
draw_roundrect_color(barX, barY, barX + barWidth, barY + barHeight, troughColor, troughColor, false);

// Fill (gradient deep blue -> icy cyan), rounded ends, min width so the cap doesn't collapse
var fillWidth = max(barHeight * 0.6, barWidth * coldBarPct);
if (coldBarPct > 0) {
    
    var coldDeep = c_aqua;
    var coldBright = c_blue;
    var dangerDeep = make_color_rgb(90, 20, 20);
    var dangerBright = make_color_rgb(170, 50, 40);
    
    var fillDeep = merge_color(coldDeep, dangerDeep, dangerBlend);
    var fillBright = merge_color(coldBright, dangerBright, dangerBlend);
    draw_roundrect_color(barX, barY, barX + fillWidth, barY + barHeight, fillDeep, fillBright, false);
    
    // Glossy highlight along the top third of the fill
    draw_set_alpha(0.12);
    draw_roundrect_color(barX + 2, barY + 2, barX + fillWidth - 2, barY + barHeight * 0.45, c_white, c_white, false);
    draw_set_alpha(1);
}

// Critical-zone marker at 30%
var markerX = barX + barWidth * 0.3;
draw_set_alpha(0.8);
draw_line_width_color(markerX, barY - 1, markerX, barY + barHeight + 1, 2, c_white, c_white);
draw_set_alpha(1);


// Value label
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

if (announceState == "completeAnim") {
    draw_set_color(c_lime);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_transformed(guiW/2, 100, "Objective Completed", max(0.01, announceScale) * 2, max(0.01, announceScale) * 2, 0);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
else if (announceState == "nextAnim") {
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_transformed(guiW/2, 100, "Next: " + announceText, max(0.01, announceScale) * 2, max(0.01, announceScale) * 2, 0);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// --- Fade to black on restart ---
if (fadeState == "fadingOut") {
    draw_set_alpha(fadeAlpha);
    draw_rectangle_color(0, 0, guiW, guiH, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
}