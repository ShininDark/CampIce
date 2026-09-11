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
    if (image_index >= image_number - 1) {
        image_index = image_number - 1;
        image_speed = 0;
    }
    exit;
}

if (flickerTimer > 0) {
    flickerTimer -= oGlobal.dt;
    if (flickerTimer < 0) flickerTimer = 0;
}

if (!global.coldLampHeadsUpShown && cold <= 60) {
    show_debug_message("Triggering cutscene, flag was: " + string(global.coldLampHeadsUpShown));
    global.coldLampHeadsUpShown = true;
    startColdLampCutscene();
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

if (mouse_check_button_pressed(mb_left) && attackTimer >= attackCooldown) {
    playSfx(sndSword);
    playerState = "attack";
    attackTimer = 0;
    attackAnimPlaying = true;
    
    sprite_index = sPlayerAttack;
    image_index = 0;
    image_speed = 1;
    
    var target = instance_nearest(x, y, oEnemy);
    if (target != noone && point_distance(x, y, target.x, target.y) <= attackRange) {
        target.takeDamage(attackDamage);
    }
}

// --- State resolution ---
var moveLen = point_distance(0, 0, hMove, vMove);
var isMoving = moveLen > 0;

if (playerState == "attack" && attackAnimPlaying) {
    sprite_index = sPlayerAttack;
    if (image_index >= image_number - 1) {
        attackAnimPlaying = false;
        playerState = isMoving ? "walk" : "idle";
    }
} else {
    playerState = isMoving ? "walk" : "idle";
    sprite_index = (playerState == "walk") ? sPlayerWalk : sPlayerIdle;
}

// Movement
if (moveLen > 0) {
    hMove /= moveLen;
    vMove /= moveLen;
}

hsp = hMove * playerSpeed * oGlobal.dt;
vsp = vMove * playerSpeed * oGlobal.dt;

moveWithTileCollision();

// Campice warmth logic
var distToIce = point_distance(x, y, oCampice.x, oCampice.y);

if (distToIce < coolRadius) {
    cold += coldRegen * oGlobal.dt;
} else {
    cold -= coldDrain * oGlobal.dt;
}

cold = clamp(cold, 0, coldMax);

// --- Mining Ores ---
nearestMineral = instance_nearest(x, y, oMineral);
if (prevMiningTarget != noone && instance_exists(prevMiningTarget) && prevMiningTarget != nearestMineral) {
    prevMiningTarget.isMining = false;
}

if (nearestMineral != noone && point_distance(x, y, nearestMineral.x, nearestMineral.y) < 32) {
    if (mouse_check_button(mb_left)) {
        nearestMineral.isMining = true;
        mineTimer += oGlobal.dt;
        
        if (mineTimer >= mineInterval) {
            nearestMineral.mineralHealth--;
            show_debug_message("Mineral Health = " + string(nearestMineral.mineralHealth));
            spawnFloatingText(nearestMineral.x, nearestMineral.y - 20, "-1", c_white);
            mineTimer = 0;
            
            if (nearestMineral.mineralHealth <= 0) {
                var minedType = nearestMineral.mineralType;
                var itemDef = getItemDef(minedType);
                
                if (itemDef != noone) {
                    spawnDrop(itemDef, 1, nearestMineral.x, nearestMineral.y);
                }
                
                clearCollisionAt(nearestMineral.x, nearestMineral.y);
                array_push(global.harvestedNodeIds, nearestMineral.saveId);
                instance_destroy(nearestMineral);
                if (global.questStage == 1) {
                    global.questStage = 2;
                } else if (global.questStage == 100) {
                    global.questOreCount = min(global.questOreCount + 1, global.questOreTarget);
                }
            }
        }
    } else {
        nearestMineral.isMining = false;
        mineTimer = 0;
    }
}

prevMiningTarget = nearestMineral;

// --- Chopping Trees ---
nearestTree = instance_nearest(x, y, oTree);
if (prevChopTarget != noone && instance_exists(prevChopTarget) && prevChopTarget != nearestTree) {
    prevChopTarget.isMining = false;
}

if (nearestTree != noone && point_distance(x, y, nearestTree.x, nearestTree.y) < 32) {
    if (mouse_check_button(mb_left)) {
        nearestTree.isMining = true;
        chopTimer += oGlobal.dt;
        
        if (chopTimer >= chopInterval) {
            nearestTree.treeHealth--;
            show_debug_message("Tree Health = " + string(nearestTree.treeHealth));
            spawnFloatingText(nearestTree.x, nearestTree.y - 20, "-1", c_white);
            chopTimer = 0;
            
            if (nearestTree.treeHealth <= 0) {
                var choppedType = nearestTree.treeType;
                var itemDef = getItemDef(choppedType);
                
                if (itemDef != noone) {
                    spawnDrop(itemDef, 1, nearestTree.x, nearestTree.y);
                }
                
                clearCollisionAt(nearestTree.x, nearestTree.y);
                array_push(global.harvestedNodeIds, nearestTree.saveId);
                instance_destroy(nearestTree);
                if (global.questStage == 2) {
                    global.questStage = 3;
                } else if (global.questStage == 100) {
                    global.questLogCount = min(global.questLogCount + 1, global.questLogTarget);
                }
            }
        }
    } else {
        nearestTree.isMining = false;
        chopTimer = 0;
    }
}

prevChopTarget = nearestTree;

var isInteracting = (nearestMineral != noone && instance_exists(nearestMineral) && nearestMineral.isMining) 
                  || (nearestTree != noone && instance_exists(nearestTree) && nearestTree.isMining);

if (playerState != "attack" && isInteracting) {
    if (!wasInteracting) {
        image_index = 0;
    }
    playerState = "interact";
    sprite_index = sPlayerAttack;
    image_speed = 1;
}

wasInteracting = isInteracting;

// --- ANCHOR COOLDOWN & TRIGGER ---
// Drain 40s cooldown timer using delta time
if (variable_instance_exists(id, "anchorCooldown") && anchorCooldown > 0) {
    anchorCooldown -= oGlobal.dt;
    if (anchorCooldown < 0) anchorCooldown = 0;
}

// Space Press Logic
if (keyboard_check_pressed(vk_space)) {
    if (!instance_exists(oAnchor)) {
        // First Press: Spawn Anchor at mouse position if off cooldown
        if (anchorCooldown <= 0) {
            instance_create_layer(mouse_x, mouse_y, "Instances", oAnchor);
        }
    } else {
        // Second Press: Trigger pull state
        with (oAnchor) {
            if (state == "attached" || state == "planted") {
                state = "pulling";
            }
        }
    }
}