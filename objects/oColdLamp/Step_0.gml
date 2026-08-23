// cooldown countdown
if (!isLit) {
    cooldownTimer += oGlobal.dt;
    if (cooldownTimer >= cooldownDuration) {
        isLit = true;
        image_index = 0; // lit frame
        cooldownTimer = 0;
    }
}

// interaction
if (isLit && instance_exists(oPlayer)) {
    if (point_distance(x, y, oPlayer.x, oPlayer.y) < interactRadius) {
        if (keyboard_check_pressed(ord("E"))) {
            oPlayer.cold += coldAmount;
            oPlayer.cold = clamp(oPlayer.cold, 0, oPlayer.coldMax);
            
            isLit = false;
            image_index = 1; // unlit frame
            cooldownTimer = 0;
        }
    }
}