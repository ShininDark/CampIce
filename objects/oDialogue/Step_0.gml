if (active) {
    global.gamePaused = true;
    
    if (keyboard_check_pressed(ord("E")) || mouse_check_button_pressed(mb_left)) {
        lineIndex++;
        
        if (lineIndex >= array_length(lines)) {
            active = false;
            
            // Only unpause here if no cutscene is still driving the pause.
            if (!instance_exists(oCutscene) || !oCutscene.active) {
                global.gamePaused = false;
            }
            
            var cb = onComplete;
            onComplete = noone;
            if (cb != noone) {
                cb();
            }
        }
    }
}