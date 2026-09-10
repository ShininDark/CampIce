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

if (instance_exists(oPlayer)) {
    var coldPct = oPlayer.cold / oPlayer.coldMax;
    
    if (coldPct < 0.3) {
        heartbeatTimer += oGlobal.dt;
        
        if (!heartbeatAudioPlaying) {
            heartbeatAudioPlaying = true;
            playMusic(sndHeartbeat, true);
        }
    } else {
        heartbeatTimer = 0;
        
        if (heartbeatAudioPlaying) {
            heartbeatAudioPlaying = false;
            playMusic(sndMainMusic, true);
        }
    }
}

if (barPopTimer > 0) {
    barPopTimer += oGlobal.dt;
    if (barPopTimer >= barPopDuration) {
        barPopTimer = 0;
    }
}

var announceKey = getQuestObjectiveKey();

if (announceKey != lastAnnouncedKey) {
    if (lastAnnouncedKey == "") {
        // very first objective — no prior quest to "complete", jump straight to announcing it
        announceState = "nextAnim";
        announceTimer = 0;
        announceScale = 0;
        announceText = getQuestHudText();
    } else {
        announceState = "completeAnim";
        announceTimer = 0;
        announceScale = 0;
    }
    lastAnnouncedKey = announceKey;
}

var popInDur = 0.4;
var completeDur = 2.2;
var nextDur = 6.0;

if (announceState == "completeAnim") {
    announceTimer += oGlobal.dt;
    var t1 = clamp(announceTimer / popInDur, 0, 1);
    announceScale = 1 - power(1 - t1, 3);
    
    if (announceTimer >= completeDur) {
        announceState = "nextAnim";
        announceTimer = 0;
        announceScale = 0;
        announceText = getQuestHudText();
    }
}
else if (announceState == "nextAnim") {
    announceTimer += oGlobal.dt;
    var t2 = clamp(announceTimer / popInDur, 0, 1);
    announceScale = 1 - power(1 - t2, 3);
    
    if (announceTimer >= nextDur) {
        announceState = "hidden";
    }
}