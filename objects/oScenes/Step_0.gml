if (!active) exit;

if (justActivated) {
    justActivated = false;
    exit;
}

// --- Fade progression ---
if (fadeState == "fadingOut") {
    fadeAlpha += fadeSpeed;
    if (fadeAlpha >= 1) {
        fadeAlpha = 1;
        sceneIndex = pendingSceneIndex;
        lineIndex = 0;
        fadeState = "fadingIn";
    }
    exit; // no input processing while fading
}

if (fadeState == "fadingIn") {
    fadeAlpha -= fadeSpeed;
    if (fadeAlpha <= 0) {
        fadeAlpha = 0;
        fadeState = "none";
    }
    exit;
}

// --- Normal input handling (only when not mid-fade) ---
if (keyboard_check_pressed(ord("E")) || mouse_check_button_pressed(mb_left)) {
    lineIndex++;
    
    var currentScene = scenes[sceneIndex];
    
    if (lineIndex >= array_length(currentScene.lines)) {
        var nextIndex = sceneIndex + 1;
        
        if (nextIndex >= array_length(scenes)) {
            // sequence fully done — fade out one last time, then stop
            fadeState = "fadingOutFinal";
            fadeAlpha = 0;
        } else {
            // more scenes left — fade out, then switch to the next one
            pendingSceneIndex = nextIndex;
            fadeState = "fadingOut";
            fadeAlpha = 0;
        }
    }
}

// --- Handle final fade-out (end of whole sequence) ---
if (fadeState == "fadingOutFinal") {
    fadeAlpha += fadeSpeed;
    if (fadeAlpha >= 1) {
        active = false;
        global.gamePaused = false;
        
        var cb = onComplete;
        onComplete = noone;
        if (cb != noone) {
            cb();
        }
    }
}