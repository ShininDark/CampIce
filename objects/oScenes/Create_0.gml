active = false;
sceneIndex = 0;
lineIndex = 0;
scenes = [];
onComplete = noone;

justActivated = false;

// fade transition state
fadeState = "none"; // none, fadingOut, fadingIn
fadeAlpha = 0;
fadeSpeed = 0.03; // tune for faster/slower fades
pendingSceneIndex = 0; // which scene to switch to once fade-out completes