// Restart Background Music from the start when Anchor finishes
if (audio_exists(sndMainMusic)) {
    audio_stop_sound(sndMainMusic);
    audio_play_sound(sndMainMusic, 1, true);
}

// Free memory allocation
if (ds_exists(tetheredEnemies, ds_type_list)) {
    ds_list_destroy(tetheredEnemies);
}

if (part_system_exists(partSys)) {
    part_system_destroy(partSys);
}