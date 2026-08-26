chaseRadius = 120;
mobSpeed = 70; // whatever speed you want, if not already set
hsp = 0;
vsp = 0;

// Cache the collision tilemap so movement doesn't have to look it up every frame.
// If the room has no "tile_collide" layer, movement should still work without crashing.
collTilemap = -1;
if (layer_exists("tile_collide")) {
    collTilemap = layer_tilemap_get_id("tile_collide");
}