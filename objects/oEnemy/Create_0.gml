event_inherited();

sprite_index = sEnemyIdle;
enemyState = "idle";

attackRadius = 24;
attackCooldown = 1.0;
attackTimer = 0;
attackDamage = 10;

facingRight = true;

flickerTimer = 0;
flickerDuration = 0.5; // seconds of white flash per hit

// health
hp = 30;
isDead = false;

takeDamage = function(amount) {
    if (isDead) return;
    
    show_debug_message("takeDamage called, amount=" + string(amount));

    hp -= amount;
    flickerTimer = flickerDuration; // start the flash
    
    if (hp <= 0) {
        hp = 0;
        isDead = true;
        enemyState = "dead";
        sprite_index = sEnemyDeath;
        image_index = 0;
        image_speed = 1;
        
        spawnDrop(global.itemShard, 1, x, y);
        
        if (global.questStage == 3) {
            global.questStage = 100; // tutorial done, enter parallel phase
        } else if (global.questStage == 100) {
            global.questKillCount = min(global.questKillCount + 1, global.questKillTarget);
        }
        
        alarm[0] = room_speed * 2;
    }
}