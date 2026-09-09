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
        typedChars = 0;
        typeTimer = 0;
        fadeState = "fadingIn";
    }
    exit;
}

if (fadeState == "fadingIn") {
    fadeAlpha -= fadeSpeed;
    if (fadeAlpha <= 0) {
        fadeAlpha = 0;
        fadeState = "none";
    }
    exit;
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
    exit;
}

// --- Typewriter progression (only when not mid-fade) ---
var currentScene = scenes[sceneIndex];

if (lineIndex >= array_length(currentScene.lines)) exit;

var currentLine = currentScene.lines[lineIndex];
var lineLength = string_length(currentLine);
var isFullyTyped = typedChars >= lineLength;

// Automatic holding logic ONLY for final sEndBlack screen
if (currentScene.image == sEndBlack) {
    if (!variable_instance_exists(id, "endScreenHoldTimer")) {
        endScreenHoldTimer = 0;
    }
    
    endScreenHoldTimer += delta_time / 1000000;
    
    // Auto-advance after roughly 3 seconds
    if (endScreenHoldTimer >= 3.0) {
        endScreenHoldTimer = 0;
        fadeState = "fadingOutFinal";
        fadeAlpha = 0;
    }
    exit; // Skip key-press checks for final title screen
} else {
    endScreenHoldTimer = 0;
}

if (!isFullyTyped) {
    typeTimer += delta_time / 1000000;
    var charsToShow = floor(typeTimer * typeSpeed);
    typedChars = min(charsToShow, lineLength);
}

// Player input to continue dialogue
if (keyboard_check_pressed(ord("E")) || mouse_check_button_pressed(mb_left)) {
    if (!isFullyTyped) {
        typedChars = lineLength;
    } else {
        lineIndex++;
        typedChars = 0;
        typeTimer = 0;
        
        if (lineIndex >= array_length(currentScene.lines)) {
            var nextIndex = sceneIndex + 1;
            
            if (nextIndex >= array_length(scenes)) {
                fadeState = "fadingOutFinal";
                fadeAlpha = 0;
            } else {
                pendingSceneIndex = nextIndex;
                fadeState = "fadingOut";
                fadeAlpha = 0;
            }
        }
    }
}