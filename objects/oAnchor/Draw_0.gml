// Draw the anchor sprite normally
draw_self();

// Draw electric line to targets
for (var i = 0; i < ds_list_size(tetheredEnemies); i++) {
    var enemy = tetheredEnemies[| i];
    
    if (instance_exists(enemy)) {
        var lineCol = choose(c_aqua, c_white, c_teal);
        draw_line_width_color(x, y, enemy.x, enemy.y, 2, lineCol, lineCol);
    }
}