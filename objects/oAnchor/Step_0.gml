switch (state) {
    case "attached":
        for (var i = 0; i < ds_list_size(tetheredEnemies); i++) {
            var enemy = tetheredEnemies[| i];
            if (instance_exists(enemy)) {
                enemy.image_blend = c_aqua;
            }
        }
        break;

    case "pulling":
        var allArrived = true;
        var activeEnemies = 0;

        for (var i = 0; i < ds_list_size(tetheredEnemies); i++) {
            var enemy = tetheredEnemies[| i];

            if (instance_exists(enemy)) {
                activeEnemies++;

                // Stop enemy movement variables so they don't block/push oPlayer
                if (variable_instance_exists(enemy, "hsp")) enemy.hsp = 0;
                if (variable_instance_exists(enemy, "vsp")) enemy.vsp = 0;

                var dir = point_direction(enemy.x, enemy.y, x, y);
                var dist = point_distance(enemy.x, enemy.y, x, y);

                if (dist > pullSpeed) {
                    enemy.x += lengthdir_x(pullSpeed, dir);
                    enemy.y += lengthdir_y(pullSpeed, dir);
                    allArrived = false;
                } else {
                    enemy.x = x;
                    enemy.y = y - 2; // Offset slightly above ground/player collision box
                }
            }
        }

        if (activeEnemies == 0) {
            instance_destroy();
            exit;
        }

        if (allArrived) {
            state = "slamming";
            slamTimer = 0;
            soulScale = 1;
            soulAlpha = 1;
        }
        break;

    case "slamming":
        slamTimer++;

        // Fast soul expansion & fade out
        soulScale += 0.35; 
        soulAlpha = max(0, 1 - (slamTimer / slamDuration));

        // Impact frame effects
        if (slamTimer == 1) {
            part_particles_create(partSys, x, y, partTypeSpark, 60);

            if (audio_exists(sndEnemySlam)) {
                audio_play_sound(sndEnemySlam, 1, false);
            }
        }

        // Lock caught enemies and flash them
        for (var i = 0; i < ds_list_size(tetheredEnemies); i++) {
            var enemy = tetheredEnemies[| i];
            if (instance_exists(enemy)) {
                enemy.x = x;
                enemy.y = y - 2;
                enemy.image_blend = (slamTimer % 2 == 0) ? c_white : c_aqua;
            }
        }

        // --- GUARANTEED DESTRUCTION & 30S COOLDOWN ---
        if (slamTimer >= slamDuration) {
            for (var i = 0; i < ds_list_size(tetheredEnemies); i++) {
                var enemy = tetheredEnemies[| i];

                if (instance_exists(enemy)) {
                    if (variable_instance_exists(enemy, "takeDamage")) {
                        enemy.takeDamage(99999);
                    } 
                    if (instance_exists(enemy) && variable_instance_exists(enemy, "hp")) {
                        enemy.hp = 0;
                    } 
                    if (instance_exists(enemy)) {
                        instance_destroy(enemy);
                    }
                }
            }

            // Set 30s cooldown
            if (instance_exists(oPlayer)) {
                oPlayer.anchorCooldown = 30; 
            }

            instance_destroy();
        }
        break;
}