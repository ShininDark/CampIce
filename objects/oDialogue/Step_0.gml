if (active) {
    global.gamePaused = true;
    
    var currentLine = lines[lineIndex];
    var lineLength = string_length(currentLine);
    var isFullyTyped = typedChars >= lineLength;
    
    // Advance the typewriter effect over time
    if (!isFullyTyped) {
        typeTimer += oGlobal.dt;
        var charsToShow = floor(typeTimer * typeSpeed);
        typedChars = min(charsToShow, lineLength);
    }
    
    if (keyboard_check_pressed(ord("E")) || mouse_check_button_pressed(mb_left)) {
        if (!isFullyTyped) {
            // First press: skip straight to the full line
            typedChars = lineLength;
        } else {
            // Line already fully shown: advance to the next one
            lineIndex++;
            typedChars = 0;
            typeTimer = 0;
            
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
}