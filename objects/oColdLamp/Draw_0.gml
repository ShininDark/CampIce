var playerBehind = false;

if (instance_exists(oPlayer)) {
    var isBehindY = oPlayer.y < y;
    
    var overlapping = !(oPlayer.bbox_right < bbox_left || oPlayer.bbox_left > bbox_right ||
                         oPlayer.bbox_bottom < bbox_top || oPlayer.bbox_top > bbox_bottom);
    
    playerBehind = isBehindY && overlapping;
}

var targetAlpha = playerBehind ? 0.4 : 1;
image_alpha = lerp(image_alpha, targetAlpha, 0.15);

draw_self();