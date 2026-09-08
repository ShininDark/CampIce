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
}

// --- Typewriter progression (only when not mid-fade) ---
var currentScene = scenes[sceneIndex];

if (lineIndex >= array_length(currentScene.lines)) exit; // mid-transition, nothing to type

var currentLine = currentScene.lines[lineIndex];
var lineLength = string_length(currentLine);
var isFullyTyped = typedChars >= lineLength;

if (!isFullyTyped) {
    typeTimer += delta_time / 1000000;
    var charsToShow = floor(typeTimer * typeSpeed);
    typedChars = min(charsToShow, lineLength);
}

if (keyboard_check_pressed(ord("E")) || mouse_check_button_pressed(mb_left)) {
    if (!isFullyTyped) {
        // First press: skip straight to the full line
        typedChars = lineLength;
    } else {
        // Line already fully shown: advance
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
