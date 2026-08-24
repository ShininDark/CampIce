state = "planted"; 
tetherRadius = 250; 
pullSpeed = 10;     
tetheredEnemies = ds_list_create();

// Keep scale normal (adjust only if using high-res sprite)
image_xscale = 1;
image_yscale = 1;

// Find nearby actual enemies on spawn (replaces oEnemy with oEnemyParent or your demon object)
var targetObject = instance_exists(oEnemyParent) ? oEnemyParent : oEnemy;

with (targetObject) {
    if (point_distance(x, y, other.x, other.y) <= other.tetherRadius) {
        ds_list_add(other.tetheredEnemies, id);
    }
}