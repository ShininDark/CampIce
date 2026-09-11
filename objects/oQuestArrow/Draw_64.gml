if (target == noone || !instance_exists(target) || !instance_exists(oPlayer) || global.gamePaused) exit;

var cam = view_camera[0];
var camX = camera_get_view_x(cam);
var camY = camera_get_view_y(cam);
var camW = camera_get_view_width(cam);
var camH = camera_get_view_height(cam);

var guiW = display_get_gui_width();
var guiH = display_get_gui_height();
var scaleX = guiW / camW;
var scaleY = guiH / camH;

// Is the target actually visible within the camera view right now?
var margin = 16; // small buffer so the arrow switches slightly before the edge
var onScreen = (target.x > camX + margin && target.x < camX + camW - margin &&
                target.y > camY + margin && target.y < camY + camH - margin);

var bob = sin(bobTimer * 4) * bobAmount;

if (onScreen) {
    var screenX = (target.x - camX) * scaleX;
    var screenY = (target.y - camY) * scaleY - 60 + bob;
    
    draw_sprite_ext(sArrow, 0, screenX, screenY, arrowScale, arrowScale, 0, c_white, 1); // sprite already points down
}
else {
    // Target is off-screen: point from the player toward it, clamped to the screen edge
    var dir = point_direction(oPlayer.x, oPlayer.y, target.x, target.y);
    
    var centerX = guiW / 2;
    var centerY = guiH / 2;
    var edgeMargin = 50;
    
    // Find where a ray from center in `dir` hits the screen border
    var dx = lengthdir_x(1, dir);
    var dy = lengthdir_y(1, dir);
    
    var halfW = (guiW / 2) - edgeMargin;
    var halfH = (guiH / 2) - edgeMargin;
    
    var scale = infinity;
    if (dx != 0) scale = min(scale, abs(halfW / dx));
    if (dy != 0) scale = min(scale, abs(halfH / dy));
    
    var arrowX = centerX + dx * scale;
    var arrowY = centerY + dy * scale;
    
    // Small bob along the direction it's pointing, for a "pulsing forward" feel
    var bobOffsetX = lengthdir_x(bob, dir);
    var bobOffsetY = lengthdir_y(bob, dir);
    
    draw_sprite_ext(sArrow, 0, arrowX + bobOffsetX, arrowY + bobOffsetY, arrowScale, arrowScale, dir + 90, c_white, 1);

}