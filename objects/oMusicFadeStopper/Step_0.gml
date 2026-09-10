timer -= oGlobal.dt;
if (timer <= 0) {
    if (audio_is_playing(soundId)) {
        audio_stop_sound(soundId);
    }
    instance_destroy();
}