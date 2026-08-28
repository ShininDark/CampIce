depth = -y;

// --- Death check ---
if (!isDead && cold <= 0) {
    isDead = true;
    playerState = "dead";
    sprite_index = sPlayerDeath;
    image_index = 0;
    image_speed = 1;
}

if (isDead) {
    // freeze the death animation on its last frame instead of looping
    if (image_index >= image_number - 1) {
        image_index = image_number - 1;
        image_speed = 0;
    }
    exit; // skip movement/attack/mining while dead
}

if (global.gamePaused) {
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

// Movement + collision — resolves each axis separately so the player can
// slide along walls instead of stopping dead on diagonal input.
moveWithTileCollision();

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
                
                clearCollisionAt(nearestMineral.x, nearestMineral.y);
                instance_destroy(nearestMineral);
                if (global.questStage == 1) {
                    global.questStage = 2;
                } else if (global.questStage == 100) {
                    global.questOreCount = min(global.questOreCount + 1, global.questOreTarget);
                }
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
                
                clearCollisionAt(nearestTree.x, nearestTree.y);
                instance_destroy(nearestTree);
                if (global.questStage == 2) {
                    global.questStage = 3;
                } else if (global.questStage == 100) {
                    global.questLogCount = min(global.questLogCount + 1, global.questLogTarget);
                }
            }
        }
    }
    else {
        nearestTree.isMining = false;
        chopTimer = 0;
    }
}

prevChopTarget = nearestTree;

// --- LIGHTNING TETHER ANCHOR TRIGGER & COOLDOWN ---
if (variable_instance_exists(id, "anchorCooldown") && anchorCooldown > 0) {
    anchorCooldown -= oGlobal.dt;
}

if (keyboard_check_pressed(vk_space)) {
    if (!instance_exists(oAnchor)) {
        // Only spawn if off cooldown
        if (anchorCooldown <= 0) {
            instance_create_layer(mouse_x, mouse_y, "Instances", oAnchor);
        }
    } else {
        // Trigger pull if anchor is planted, then set 60s (1 min) cooldown
        with (oAnchor) {
            if (state == "planted") {
                state = "pulling";
                other.anchorCooldown = 60; // 60-second cooldown
            }
        }
    }
}
