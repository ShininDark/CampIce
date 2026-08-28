function startSceneSequence(sceneArray, callback = noone) {
    global.gamePaused = true;
    
    with (oScenes) {
        active = true;
        justActivated = true;
        sceneIndex = 0;
        lineIndex = 0;
        onComplete = callback;
        
        scenes = array_create(array_length(sceneArray));
        for (var i = 0; i < array_length(sceneArray); i++) {
            scenes[i] = sceneArray[i];
        }
        
        // start fully black, then fade in to reveal scene 1
        fadeState = "fadingIn";
        fadeAlpha = 1;
    }
}