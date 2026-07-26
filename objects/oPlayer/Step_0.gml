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

if (nearestMineral != noone && point_distance(x, y, nearestMineral.x, nearestMineral.y) < 32){
    if (mouse_check_button(mb_left)){
        mineTimer += oGlobal.dt;
        
        if (mineTimer >= mineInterval) {
            nearestMineral.mineralHealth --;
            show_debug_message("Mineral Health = " + string(nearestMineral.mineralHealth));
            mineTimer = 0;
            
            if (nearestMineral.mineralHealth <= 0){
                instance_destroy(nearestMineral);
            }
        }
        
    }
    else {
        mineTimer = 0;  // this will make the timer start again if player releases before finishing.
    }
}

