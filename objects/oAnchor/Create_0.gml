// --- ANIMATION & SOUL EFFECT VARIABLES ---
auraAngle = 0;
pulseScale = 1;

// Ghostly Soul Expansion variables
soulScale = 1;
soulAlpha = 0;

state = "attached";
tetherRadius = 250; 
pullSpeed = 14;     
tetheredEnemies = ds_list_create();

slamTimer = 0;
slamDuration = 12;

// Spark Particle System
partSys = part_system_create();
partTypeSpark = part_type_create();
part_type_shape(partTypeSpark, pt_shape_spark);
part_type_size(partTypeSpark, 0.4, 0.8, -0.02, 0);
part_type_color2(partTypeSpark, c_white, c_aqua);
part_type_alpha2(partTypeSpark, 1, 0);
part_type_speed(partTypeSpark, 8, 16, -0.3, 0);
part_type_direction(partTypeSpark, 0, 360, 0, 0);
part_type_life(partTypeSpark, 12, 22);

var targetObject = instance_exists(oEnemyParent) ? oEnemyParent : oEnemy;

with (targetObject) {
    if (point_distance(x, y, other.x, other.y) <= other.tetherRadius) {
        ds_list_add(other.tetheredEnemies, id);
    }
}

if (ds_list_size(tetheredEnemies) == 0) {
    instance_destroy();
    exit;
}

if (audio_exists(sndMainMusic) && audio_is_playing(sndMainMusic)) {
    audio_pause_sound(sndMainMusic);
}