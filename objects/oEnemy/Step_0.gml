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

event_inherited(); // run parent's movement/separation/collision AFTER state logic