timer += oGlobal.dt;

if (mode == "drift") {
    y -= floatSpeed * oGlobal.dt;
    if (timer >= lifeTime) {
        instance_destroy();
    }
}
else if (mode == "flyToHud") {
    flyTimer += oGlobal.dt;
    var t = clamp(flyTimer / flyDuration, 0, 1);
    // ease-in toward the target for a snappier arrival
    var easedT = t * t;
    
    if (t >= 1) {
        var cb = onArrive;
        onArrive = noone;
        if (cb != noone) {
            cb();
        }
        instance_destroy();
    }
}