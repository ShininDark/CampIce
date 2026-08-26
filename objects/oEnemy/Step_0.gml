// --- Skip AI while being yanked by Lightning Tether ---
if (variable_instance_exists(id, "isTethered") && isTethered) {
    exit;
}

if (isDead) {
    image_alpha = lerp(image_alpha, 0, 0.05);
    exit;
}

if (instance_exists(oPlayer) && oPlayer.isDead) {
    sprite_index = sEnemyIdle;
    hsp = 0;
    vsp = 0;
    exit; // stop chasing/attacking once the player is dead
}

var distToPlayer = point_distance(x, y, oPlayer.x, oPlayer.y);

// facing
if (oPlayer.x < x) facingRight = false;
else if (oPlayer.x > x) facingRight = true;
image_xscale = facingRight ? 1 : -1;

// state transitions
if (distToPlayer <= attackRadius) {
    enemyState = "attack";
} else if (distToPlayer <= chaseRadius) {
    enemyState = "chase";
} else {
    enemyState = "idle";
}

// sprite + attack logic per state
switch (enemyState) {
    case "idle":
        sprite_index = sEnemyIdle;
        break;
        
    case "chase":
        sprite_index = sEnemyWalk;
        break;
        
    case "attack":
        sprite_index = sEnemyAttack;
        attackTimer += oGlobal.dt;
        if (attackTimer >= attackCooldown) {
            oPlayer.cold -= attackDamage;
            oPlayer.cold = clamp(oPlayer.cold, 0, oPlayer.coldMax);
            attackTimer = 0;
        }
        break;
}

event_inherited();