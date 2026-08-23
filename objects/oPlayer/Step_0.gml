// --- Death check ---
if (!isDead && cold <= 0) {
    isDead = true;
    playerState = "dead";
    sprite_index = sPlayerDeath;
    image_index = 0;
    image_speed = 1;
}

if (isDead) {
    // freeze everything else — skip movement/attack/mining while dead
    exit;
}

// --- Facing ---
var hMove = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var vMove = keyboard_check(ord("S")) - keyboard_check(ord("W"));

if (hMove < 0) facingRight = false;
else if (hMove > 0) facingRight = true;
image_xscale = facingRight ? 1 : -1;

// --- Attack timer ---
attackTimer += oGlobal.dt;

// --- Attack trigger ---
if (mouse_check_button_pressed(mb_left) && attackTimer >= attackCooldown) {
    playerState = "attack";
    attackTimer = 0;
    
    // find nearest enemy in range
    var target = instance_nearest(x, y, oEnemy);
    if (target != noone && point_distance(x, y, target.x, target.y) <= attackRange) {
        target.takeDamage(attackDamage);
    }
}

// --- State resolution (movement vs attack vs idle) ---
var moveLen = point_distance(0,0,hMove,vMove);
var isMoving = moveLen > 0;

if (playerState == "attack") {
    sprite_index = sPlayerAttack;
    // stay in attack state until timer passes a short "swing duration"
    if (attackTimer >= 0.3) { // swing visual duration, tweak to taste
        playerState = isMoving ? "walk" : "idle";
    }
} else {
    playerState = isMoving ? "walk" : "idle";
    sprite_index = (playerState == "walk") ? sPlayerWalk : sPlayerIdle;
}

// Player movement
if (moveLen > 0){
    hMove /= moveLen;
    vMove /= moveLen;
}

hsp = hMove * playerSpeed * oGlobal.dt;
vsp = vMove * playerSpeed * oGlobal.dt;

// Horizontal movement + collision 
var newX = x + hsp; 
if (!tileCollision(newX, y)) { 
    x = newX;
} 
else {
    hsp = 0; // stop horizontal glide if blocked
}
    
// Vertical movement + collision
var newY = y + vsp;
if (!tileCollision(x, newY)) {
    y = newY;
} 
else {
    vsp = 0; // stop vertical glide if blocked
}

// Campice
var distToIce = point_distance(x, y, oCampice.x, oCampice.y);

if (distToIce < coolRadius) {
    cold += coldRegen * oGlobal.dt;
}
else{
    cold -= coldDrain * oGlobal.dt;
}

cold = clamp(cold, 0, coldMax);



// mining ores
nearestMineral = instance_nearest(x, y, oMineral);
if (prevMiningTarget != noone && instance_exists(prevMiningTarget) && prevMiningTarget != nearestMineral) {
    prevMiningTarget.isMining = false;
}

if (nearestMineral != noone && point_distance(x, y, nearestMineral.x, nearestMineral.y) < 32){
    if (mouse_check_button(mb_left)){
        nearestMineral.isMining = true;
        mineTimer += oGlobal.dt;
        
        if (mineTimer >= mineInterval) {
            nearestMineral.mineralHealth--;
            show_debug_message("Mineral Health = " + string(nearestMineral.mineralHealth));
            mineTimer = 0;
            
            if (nearestMineral.mineralHealth <= 0) {
                var minedType = nearestMineral.mineralType;
                var itemDef = getItemDef(minedType);
                
                if (itemDef != noone) {
                    spawnDrop(itemDef, 1, nearestMineral.x, nearestMineral.y);
                }
                
                instance_destroy(nearestMineral);
                show_debug_message("Mined: " + string(minedType));
            }
        }
    }
    else {
        nearestMineral.isMining = false;
        mineTimer = 0;
    }
}

prevMiningTarget = nearestMineral;

// chopping trees
nearestTree = instance_nearest(x, y, oTree);
if (prevChopTarget != noone && instance_exists(prevChopTarget) && prevChopTarget != nearestTree) {
    prevChopTarget.isMining = false;
}

if (nearestTree != noone && point_distance(x, y, nearestTree.x, nearestTree.y) < 32){
    if (mouse_check_button(mb_left)){
        nearestTree.isMining = true;
        chopTimer += oGlobal.dt;
        
        if (chopTimer >= chopInterval) {
            nearestTree.treeHealth--;
            show_debug_message("Tree Health = " + string(nearestTree.treeHealth));
            chopTimer = 0;
            
            if (nearestTree.treeHealth <= 0) {
                var choppedType = nearestTree.treeType;
                var itemDef = getItemDef(choppedType);
                
                if (itemDef != noone) {
                    spawnDrop(itemDef, 1, nearestTree.x, nearestTree.y);
                }
                
                instance_destroy(nearestTree);
                show_debug_message("Chopped: " + string(choppedType));
            }
        }
    }
    else {
        nearestTree.isMining = false;
        chopTimer = 0;
    }
}

prevChopTarget = nearestTree;

