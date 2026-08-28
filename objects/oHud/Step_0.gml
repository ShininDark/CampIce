if (fadeState == "fadingOut") {
    fadeAlpha += fadeSpeed;
    if (fadeAlpha >= 1) {
        fadeAlpha = 1;
        game_restart();
        // note: game_restart() reloads everything, so code after this line
        // in this specific frame won't matter — the restart happens immediately
    }
}

var currentQuestKey = getQuestObjectiveKey();
var currentQuestText = getQuestHudText();

switch (questState) {
    case "idle":
        if (currentQuestKey != lastQuestKey && lastQuestKey != "") {
            questState = "showingComplete";
            questCompleteTimer = 0;
        } else {
            questDisplayText = currentQuestText;
            lastQuestText = currentQuestText;
            lastQuestKey = currentQuestKey;
        }
        break;
        
    case "showingComplete":
        questCompleteTimer += oGlobal.dt;
        if (questCompleteTimer >= questCompleteDuration) {
            questState = "slidingIn";
            questSlideTimer = 0;
            questDisplayText = currentQuestText;
            lastQuestText = currentQuestText;
            lastQuestKey = currentQuestKey;
        }
        break;
        
    case "slidingIn":
        questSlideTimer += oGlobal.dt;
        if (questSlideTimer >= questSlideDuration) {
            questState = "idle";
        }
        break;
}