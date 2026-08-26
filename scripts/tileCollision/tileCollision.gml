// Collision grid size used when snapping out of a blocked tile.
// Independent of the tileset's visual tile size — only controls how tightly
// movement snaps to the grid when a collision is resolved.
#macro COLLISION_TILE_SIZE 16

// Checks a single world point against the collision tilemap.
// Using one point (rather than a box built from sprite_width/height) means the
// check always matches the instance's actual origin — no guessing a hitbox size,
// and no risk of the box being bigger than the gap it's supposed to block.
function tileCollision(xx, yy){
	if (collTilemap == -1 || collTilemap == noone) return false;
	return tilemap_get_at_pixel(collTilemap, xx, yy) != 0;
}

// Moves the calling instance by its own hsp/vsp, resolving tile collision on
// each axis separately so diagonal movement can slide along a wall instead of
// stopping dead. Expects the instance to already have x, y, hsp, vsp and
// collTilemap defined (set collTilemap in that instance's Create event).
function moveWithTileCollision(){
	// Horizontal pass first.
	if (tileCollision(x + hsp, y)) {
		// Snap to the edge of the blocked tile instead of just zeroing speed,
		// so the instance doesn't stop short of the wall it hit.
		x -= x mod COLLISION_TILE_SIZE;
		if (sign(hsp) == 1) x += COLLISION_TILE_SIZE - 1;
		hsp = 0;
	}
	x += hsp;
	
	// Vertical pass second, using the already-updated x.
	if (tileCollision(x, y + vsp)) {
		y -= y mod COLLISION_TILE_SIZE;
		if (sign(vsp) == 1) y += COLLISION_TILE_SIZE - 1;
		vsp = 0;
	}
	y += vsp;
}