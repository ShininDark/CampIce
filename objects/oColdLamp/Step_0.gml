depth = -y;

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
        var ft = instance_create_layer(x, y - 40, "Instances", oFloatingText);
        ft.mode = "flyToHud";
        ft.text = "+" + string(coldAmount);
        ft.color = c_aqua;
        ft.startWorldX = x;
        ft.startWorldY = y - 40;
        ft.flyDuration = 0.8;
        
        var guiW = display_get_gui_width();
        var barWidth = 200;
        ft.targetGuiX = (guiW / 2);
        ft.targetGuiY = 30; // roughly the cold bar's vertical center
        
        ft.onArrive = function() {
            oPlayer.cold += coldAmount;
            oPlayer.cold = clamp(oPlayer.cold, 0, oPlayer.coldMax);
            
            with (oHud) {
                heartbeatTimer = 0; // reset so the pop reads clean, not mid-cycle
                barPopTimer = 0.001; // triggers a one-shot pop, see step 3
            }
        };
        
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