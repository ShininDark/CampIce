// Player movement
var hMove = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var vMove = keyboard_check(ord("S")) - keyboard_check(ord("W"));

var moveLen = point_distance(0,0,hMove,vMove);
if (moveLen > 0){
    hMove /= moveLen;
    vMove /= moveLen;
}


x += hMove * playerSpeed * oGlobal.dt;
y += vMove * playerSpeed * oGlobal.dt;


// Campice
var distToIce = point_distance(x, y, oCampice.x, oCampice.y);

if (distToIce < coolRadius) {
    cold += coldRegen * oGlobal.dt;
}
else{
    cold -= coldDrain * oGlobal.dt;
}

cold = clamp(cold, 0, coldMax);
