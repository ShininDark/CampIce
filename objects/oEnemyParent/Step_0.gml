if (isDead) exit;

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

with (oEnemyParent) {
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

// Separation from the player — stops the enemy from overlapping/rendering on top of them
if (instance_exists(oPlayer)) {
    var playerSepRadius = 20; // roughly half the combined width of player+enemy sprites
    
    if (distToPlayer < playerSepRadius && distToPlayer > 0) {
        var pushDir = point_direction(oPlayer.x, oPlayer.y, x, y);
        var pushForce = (playerSepRadius - distToPlayer) / playerSepRadius;
        
        hsp += lengthdir_x(pushForce, pushDir) * mobSpeed * oGlobal.dt;
        vsp += lengthdir_y(pushForce, pushDir) * mobSpeed * oGlobal.dt;
    }
}

hsp += sepX * mobSpeed * oGlobal.dt;
vsp += sepY * mobSpeed * oGlobal.dt;

// Movement + collision — resolves each axis separately so the enemy can
// slide along walls instead of stopping dead on diagonal input.
moveWithTileCollision();

// Hard separation from the player — guarantees no overlap regardless of movement speed
var distToPlayerFinal = point_distance(x, y, oPlayer.x, oPlayer.y);
var minSeparation = 20; // tune to match your sprite sizes
if (distToPlayerFinal < minSeparation && distToPlayerFinal > 0) {
    var awayDir = point_direction(oPlayer.x, oPlayer.y, x, y);
    x = oPlayer.x + lengthdir_x(minSeparation, awayDir);
    y = oPlayer.y + lengthdir_y(minSeparation, awayDir);
}

