fadeState = "none"; // none, fadingOut, fadingIn
fadeAlpha = 0;
fadeSpeed = 0.02; // tune for faster/slower fade

lastQuestText = "";
questDisplayText = ""; // what's actually drawn (may lag behind the real quest during animation)
questCompleteTimer = 0;
questCompleteDuration = 1.2; // how long "Completed!" shows
questSlideTimer = 0;
questSlideDuration = 0.3; // how long the slide-in animation takes
questState = "idle"; // idle, showingComplete, slidingIn