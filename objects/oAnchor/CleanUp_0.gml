// Restart Background Music from the start when Anchor finishes
// was: audio_stop_sound(sndMainMusic); audio_play_sound(sndMainMusic, 1, true);
if (variable_global_exists("currentMusicId") && audio_exists(global.currentMusicId)) {
    var isCold = instance_exists(oPlayer) && (oPlayer.cold / oPlayer.coldMax) < 0.3;
    var wasHeartbeat = instance_exists(oHud) && oHud.heartbeatAudioPlaying;

    if (isCold == wasHeartbeat) {
        audio_resume_sound(global.currentMusicId); // cold state unchanged, just resume
    } else {
        playMusic(isCold ? sndHeartbeat : sndMainMusic, true); // cold changed mid-anchor
        if (instance_exists(oHud)) oHud.heartbeatAudioPlaying = isCold;
    }
}

// Free memory allocation
if (ds_exists(tetheredEnemies, ds_type_list)) {
    ds_list_destroy(tetheredEnemies);
}

if (part_system_exists(partSys)) {
    part_system_destroy(partSys);
}