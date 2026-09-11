// Pick the current target based on quest stage
target = noone;

if (global.questStage == 0) {
    target = instance_exists(oLunatic) ? instance_find(oLunatic, 0) : noone;
}
else if (global.questStage == 1) {
    if (instance_exists(oPlayer)) {
        target = instance_nearest(oPlayer.x, oPlayer.y, oMineral);
    }
}
else if (global.questStage == 2) {
    if (instance_exists(oPlayer)) {
        target = instance_nearest(oPlayer.x, oPlayer.y, oTree);
    }
}

bobTimer += oGlobal.dt;