if (fadeState == "fadingOut") {
    fadeAlpha += fadeSpeed;
    if (fadeAlpha >= 1) {
        fadeAlpha = 1;
        game_restart();
        // note: game_restart() reloads everything, so code after this line
        // in this specific frame won't matter — the restart happens immediately
    }
}