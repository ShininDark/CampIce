function playMusic(sound, loop = true, fadeTime = 800) {
    if (variable_global_exists("currentMusicId") && audio_is_playing(global.currentMusicId)) {
        audio_sound_gain(global.currentMusicId, 0, fadeTime);
        
        var stopper = instance_create_layer(0, 0, "Instances", oMusicFadeStopper);
        stopper.soundId = global.currentMusicId;
        stopper.timer = fadeTime / 1000;
    }
    
    global.currentMusicId = audio_play_sound(sound, 0, loop);
    audio_sound_gain(global.currentMusicId, 0, 0);
    audio_sound_gain(global.currentMusicId, global.musicMuted ? 0 : global.musicVolume, fadeTime);
}

function playSfx(sound) {
    var soundId = audio_play_sound(sound, 0, false);
    audio_sound_gain(soundId, global.musicMuted ? 0 : global.musicVolume, 0);
    return soundId;
}