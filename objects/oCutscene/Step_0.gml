if (!active) exit;

var cam = view_camera[0];

switch (state) {
    case "panToLunatic":
        panStartX = camera_get_view_x(cam);
        panStartY = camera_get_view_y(cam);
        panTargetX = oLunatic.x - zoomedViewW/2;
        panTargetY = oLunatic.y - zoomedViewH/2;
        panTimer = 0;
        panDuration = 1.0;
        state = "doingPanToLunatic";
        break;
        
    case "doingPanToLunatic":
        panTimer += oGlobal.dt;
        var t = clamp(panTimer / panDuration, 0, 1);
        camera_set_view_pos(cam, lerp(panStartX, panTargetX, t), lerp(panStartY, panTargetY, t));
        camera_set_view_size(cam, lerp(normalViewW, zoomedViewW, t), lerp(normalViewH, zoomedViewH, t));
        if (t >= 1) {
            state = "waitDialogue";
            startDialogue([
                "Your cold meter is ticking down.",
                "Use a cold lamp to replenish 25 cold."
            ], function() {
                with (oCutscene) {
                    state = "panToLamp";
                }
            });
        }
        break;
        
    case "panToLamp":
        targetLamp = instance_find(oColdLamp, 0);
        panStartX = camera_get_view_x(cam);
        panStartY = camera_get_view_y(cam);
        if (targetLamp != noone) {
            panTargetX = targetLamp.x - zoomedViewW/2;
            panTargetY = targetLamp.y - zoomedViewH/2;
        }
        panTimer = 0;
        panDuration = 1.0;
        state = "doingPanToLamp";
        break;
        
    case "doingPanToLamp":
        panTimer += oGlobal.dt;
        var t2 = clamp(panTimer / panDuration, 0, 1);
        camera_set_view_pos(cam, lerp(panStartX, panTargetX, t2), lerp(panStartY, panTargetY, t2));
        // already zoomed in from the previous pan, so view size stays at zoomedViewW/H here
        if (t2 >= 1) {
            state = "holdLamp";
            timer = 0;
        }
        break;
        
    case "holdLamp":
        timer += oGlobal.dt;
        if (timer >= 1.5) {
            panStartX = camera_get_view_x(cam);
            panStartY = camera_get_view_y(cam);
            panTargetX = oPlayer.x - normalViewW/2;
            panTargetY = oPlayer.y - normalViewH/2;
            panTimer = 0;
            panDuration = 1.0;
            state = "doingPanToPlayer";
        }
        break;
        
    case "doingPanToPlayer":
        panTimer += oGlobal.dt;
        var t3 = clamp(panTimer / panDuration, 0, 1);
        camera_set_view_pos(cam, lerp(panStartX, panTargetX, t3), lerp(panStartY, panTargetY, t3));
        camera_set_view_size(cam, lerp(zoomedViewW, normalViewW, t3), lerp(zoomedViewH, normalViewH, t3)); // zoom back out
        if (t3 >= 1) {
            state = "finalHold";
            timer = 0;
        }
        break;
        
    case "finalHold":
        timer += oGlobal.dt;
        if (timer >= 2.0) {
            active = false;
            global.gamePaused = false;
            camera_set_view_target(cam, oPlayer);
            camera_set_view_size(cam, normalViewW, normalViewH); // safety reset, ensures exact restoration
        }
        break;
}