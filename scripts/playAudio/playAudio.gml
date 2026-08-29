function playMusic(sound, loop = true) {
    if (variable_global_exists("currentMusicId") && audio_is_playing(global.currentMusicId)) {
        audio_stop_sound(global.currentMusicId);
    }
    global.currentMusicId = audio_play_sound(sound, 0, loop);
    audio_sound_gain(global.currentMusicId, global.musicMuted ? 0 : global.musicVolume, 0);
}

function playSfx(sound) {
    var soundId = audio_play_sound(sound, 0, false);
    audio_sound_gain(soundId, global.musicMuted ? 0 : global.musicVolume, 0);
    return soundId;
}