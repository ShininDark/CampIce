draw_self(); // normal sprite

if (flickerTimer > 0) {
    var flickerAlpha = flickerTimer / flickerDuration;
    
    shader_set(shFlash);
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, flickerAlpha);
    shader_reset();
}