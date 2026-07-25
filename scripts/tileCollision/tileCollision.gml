function tileCollision(xx, yy){
    var halfW = sprite_width * image_xscale/2;
    var halfH = sprite_height * image_yscale/2;
    
    // check corners of the bounding box at target position
    var corners = [
        [xx - halfW, yy - halfH],
        [xx + halfW, yy - halfH],
        [xx - halfW, yy + halfH],
        [xx + halfW, yy + halfH]
    ];
    
    for (var i = 0; i < array_length(corners); i++){
        var tile = tilemap_get_at_pixel(collisionTiles, corners[i][0], corners[i][1]);
        if (tile != 0){
            return true;    // hit a collision tile
        }
    }
    return false;
}