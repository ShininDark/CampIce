// Player movement
var hMove = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var vMove = keyboard_check(ord("S")) - keyboard_check(ord("W"));

var moveLen = point_distance(0,0,hMove,vMove);
if (moveLen > 0){
    hMove /= moveLen;
    vMove /= moveLen;
}

hsp = hMove * playerSpeed * oGlobal.dt;
vsp = vMove * playerSpeed * oGlobal.dt;

// Horizontal movement + collision 
var new_x = x + hsp; 
if (!tileCollision(new_x, y)) { 
    x = new_x;
} 
else {
    hsp = 0; // stop horizontal glide if blocked
}
    
// Vertical movement + collision
var new_y = y + vsp;
if (!tileCollision(x, new_y)) {
    y = new_y;
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


// for collision on boundaries


