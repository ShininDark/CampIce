event_inherited();

sprite_index = sEnemyIdle;
enemyState = "idle";

attackRadius = 24;
attackCooldown = 1.0;
attackTimer = 0;
attackDamage = 10;

facingRight = true;

// health
hp = 30;
isDead = false;

takeDamage = function(amount) {
    if (isDead) return;
    
    hp -= amount;
    if (hp <= 0) {
        hp = 0;
        isDead = true;
        enemyState = "dead";
        sprite_index = sEnemyDeath;
        image_index = 0;
        image_speed = 1;
        
        spawnDrop(global.itemShard, 1, x, y);
        
        alarm[0] = room_speed * 2; // destroy after 2 seconds
    }
}