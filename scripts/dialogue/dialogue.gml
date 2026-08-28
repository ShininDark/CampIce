function startDialogue(linesArr, callback = noone) {
    show_debug_message("startDialogue called, oDialogue exists: " + string(instance_exists(oDialogue)));
    with (oDialogue) {
        active = true;
        lines = linesArr;
        lineIndex = 0;
        onComplete = callback;
    }
}

function startColdLampCutscene() {
    global.gamePaused = true;
    
    var cam = view_camera[0];
    camera_set_view_target(cam, noone);
    
    with (oCutscene) {
        active = true;
        state = "panToLunatic";
        
        normalViewW = camera_get_view_width(cam);
        normalViewH = camera_get_view_height(cam);
        zoomedViewW = normalViewW * zoomFactor;
        zoomedViewH = normalViewH * zoomFactor;
    }
}