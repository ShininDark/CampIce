if (state == "pulling") {
    var activeCount = 0;
    
    for (var i = 0; i < ds_list_size(tetheredEnemies); i++) {
        var enemy = tetheredEnemies[| i];
        
        if (instance_exists(enemy)) {
            activeCount++;
            
            // Pull enemy toward anchor center
            var dir = point_direction(enemy.x, enemy.y, x, y);
            enemy.x += lengthdir_x(pullSpeed, dir);
            enemy.y += lengthdir_y(pullSpeed, dir);
            
            // Slam hit on arrival
            if (point_distance(enemy.x, enemy.y, x, y) <= pullSpeed) {
                enemy.x = x;
                enemy.y = y;
                
                // Deal damage using your takeDamage method if it exists, or hp directly
                if (variable_instance_exists(enemy, "takeDamage")) {
                    enemy.takeDamage(30);
                } else if (variable_instance_exists(enemy, "hp")) {
                    enemy.hp -= 30;
                }
                
                // Fixed: changed c_cyan to c_aqua to prevent variable crash
                enemy.image_blend = c_aqua;
            }
        }
    }
    
    // Destroy anchor when all tethered enemies reach the center or die
    if (activeCount == 0 || point_distance(tetheredEnemies[| 0].x, tetheredEnemies[| 0].y, x, y) <= pullSpeed) {
        instance_destroy();
    }
}