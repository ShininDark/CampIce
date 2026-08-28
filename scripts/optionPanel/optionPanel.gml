function openOptionsPanel(fromGameplay) {
    global.optionsOpen = true;
    global.gamePaused = true;
    with (oOptions) {
        justOpened = true;
        inGameMode = fromGameplay;
    }
}

function closeOptionsPanel() {
    global.optionsOpen = false;
    global.gamePaused = false;
}