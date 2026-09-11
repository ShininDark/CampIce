// --- SAFETY CHECKS ---
if (!variable_instance_exists(id, "auraAngle")) auraAngle = 0;
if (!variable_instance_exists(id, "pulseScale")) pulseScale = 1;
if (!variable_instance_exists(id, "soulScale")) soulScale = 1;
if (!variable_instance_exists(id, "soulAlpha")) soulAlpha = 0;

// Draw main ground anchor (fades out slightly during slam so the soul pops out)
var baseAlpha = (state == "slamming") ? soulAlpha : 1.0;
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, baseAlpha);

gpu_set_blendmode(bm_add);

// Spinning energy core
auraAngle += 6;
pulseScale = 1 + sin(auraAngle * 0.08) * 0.2;
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * 1.2 * pulseScale, image_yscale * 1.2 * pulseScale, auraAngle, c_aqua, 0.6 * baseAlpha);

// Lightning lines to caught enemies
if (variable_instance_exists(id, "state") && variable_instance_exists(id, "tetheredEnemies")) {
    if (state == "attached" || state == "pulling") {
        for (var i = 0; i < ds_list_size(tetheredEnemies); i++) {
            var enemy = tetheredEnemies[| i];

            if (instance_exists(enemy)) {
                var col = (state == "attached") ? choose(c_teal, c_aqua) : choose(c_white, c_aqua);
                draw_line_width_color(x, y, enemy.x, enemy.y, 3, col, c_white);
            }
        }
    }

    // --- EXPANDING SOUL BURST ---
    if (state == "slamming" && soulAlpha > 0) {
        // Transparent cyan ghost bursting huge toward screen
        draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * soulScale, image_yscale * soulScale, image_angle, c_aqua, soulAlpha);
        
        // Expanding shockwave ring fading out fast
        var progress = (slamTimer / slamDuration);
        var waveRadius = progress * (tetherRadius * 1.2);
        var waveAlpha = (1 - progress);

        draw_set_alpha(waveAlpha);
        draw_circle_color(x, y, waveRadius, c_white, c_aqua, false);
        draw_set_alpha(1.0);
    }
}

gpu_set_blendmode(bm_normal);