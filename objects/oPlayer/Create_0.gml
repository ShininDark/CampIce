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


collTilemap = layer_tilemap_get_id("tile_collide");