// cooldown countdown
if (!isLit) {
    cooldownTimer += oGlobal.dt;
    if (cooldownTimer >= cooldownDuration) {
        isLit = true;
        image_index = 0;
        cooldownTimer = 0;
    }
}

// interaction (hold-based)
var inRange = isLit && instance_exists(oPlayer) && point_distance(x, y, oPlayer.x, oPlayer.y) < interactRadius;

if (inRange && keyboard_check(vk_control)) {
    isHolding = true;
    holdTimer += oGlobal.dt;
    
    if (holdTimer >= holdDuration) {
        oPlayer.cold += coldAmount;
        oPlayer.cold = clamp(oPlayer.cold, 0, oPlayer.coldMax);
        
        isLit = false;
        image_index = 1;
        cooldownTimer = 0;
        
        isHolding = false;
        holdTimer = 0;
    }
}
else {
    isHolding = false;
    holdTimer = 0;
}