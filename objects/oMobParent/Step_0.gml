var distToPlayer = point_distance(x, y, oPlayer.x, oPlayer.y);
var stopDistance = 24; // don't get closer than this

if (distToPlayer <= chaseRadius && distToPlayer > stopDistance) {
    var dir = point_direction(x, y, oPlayer.x, oPlayer.y);
    var hMove = lengthdir_x(1, dir);
    var vMove = lengthdir_y(1, dir);
    hsp = hMove * mobSpeed * oGlobal.dt;
    vsp = vMove * mobSpeed * oGlobal.dt;
} else {
    hsp = 0;
    vsp = 0;
}

var sepX = 0, sepY = 0;
var sepRadius = 32; // roughly mob width, tweak to taste

with (oMobParent) {
    if (id != other.id) {
        var d = point_distance(other.x, other.y, x, y);
        if (d < sepRadius && d > 0) {
            var pushDir = point_direction(x, y, other.x, other.y);
            var pushForce = (sepRadius - d) / sepRadius; // stronger when closer
            sepX += lengthdir_x(pushForce, pushDir);
            sepY += lengthdir_y(pushForce, pushDir);
        }
    }
}

hsp += sepX * mobSpeed * oGlobal.dt;
vsp += sepY * mobSpeed * oGlobal.dt;

// Horizontal movement + collision
var newX = x + hsp;
if (!tileCollision(newX, y)) {
    x = newX;
} else {
    hsp = 0;
}

// Vertical movement + collision
var newY = y + vsp;
if (!tileCollision(x, newY)) {
    y = newY;
} else {
    vsp = 0;
}

