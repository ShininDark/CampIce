draw_self();

if (isMining) {
    var barW = 32;
    var barH = 5;
    var barX = x - barW/2;
    var barY = y - sprite_height/2 - 12;
    
    var pct = 1 - (treeHealth / treeHealthMax);
    
    draw_rectangle_color(barX, barY, barX + barW, barY + barH, c_black, c_black, c_black, c_black, false);
    draw_rectangle_color(barX, barY, barX + (barW * pct), barY + barH, c_lime, c_lime, c_lime, c_lime, false);
}

var playerBehind = false;

if (instance_exists(oPlayer)) {
    var isBehindY = oPlayer.y < y; // player's feet are above the tree's base
    
    var overlapping = !(oPlayer.bbox_right < bbox_left || oPlayer.bbox_left > bbox_right ||
                         oPlayer.bbox_bottom < bbox_top || oPlayer.bbox_top > bbox_bottom);
    
    playerBehind = isBehindY && overlapping;
}

var targetAlpha = playerBehind ? 0.4 : 1;
image_alpha = lerp(image_alpha, targetAlpha, 0.15); // smooth fade instead of an instant snap

draw_self();