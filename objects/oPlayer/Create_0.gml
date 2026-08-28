show_debug_message("oPlayer Create is running");
// movement
playerSpeed = 150;

// campice
cold = 100;     // for player's cold meter
coldMax = 100;
coldRegen = 10;
coldDrain = 2;
coolRadius = 200;       // for the distance within which the player is near the campice to start regening cold

// mining
mineTimer = 0;
mineInterval = 1;   // this will act as seconds between hits
prevMiningTarget = noone;

// chopping
chopTimer = 0;
chopInterval = 1;
prevChopTarget = noone;

// player state
playerState = "idle";  // idle, walk, attack, dead
facingRight = true;

attackCooldown = 1.0;
attackTimer = attackCooldown; // ready to attack immediately
attackRange = 32;
attackDamage = 10;

isDead = false;

// Cache the collision tilemap so movement doesn't have to look it up every frame.
// If the room has no "tile_collide" layer, movement should still work without crashing.
collTilemap = -1;
if (layer_exists("tile_collide")) {
    collTilemap = layer_tilemap_get_id("tile_collide");
}

hsp = 0;
vsp = 0;

anchorCooldown = 0;

startDialogue(["Hello there.", "This is a test."]);

