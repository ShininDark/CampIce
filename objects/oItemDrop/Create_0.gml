itemDef = noone;   // set by spawnDrop right after instance_create
amount = 1;

// bounce/scatter effect
var dir = random(360);
var spd = random_range(1.5, 3);
hspBounce = lengthdir_x(spd, dir);
vspBounce = lengthdir_y(spd, dir);
bounceFriction = 0.85;

// pickup lock
canPickup = false;
pickupTimer = 0;
pickupDelay = 0.8;   // seconds before it's collectible
pickupRadius = 20;

sprite_index = sOakDrop; // placeholder, overwritten by spawnDrop
image_xscale = 0.1; // pop-in scale, grows to 1 over first few frames
image_yscale = 0.1;