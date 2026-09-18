if (anchorCooldown > 0 && (!instance_exists(oScenes) || !oScenes.active)) {
    var guiW = display_get_gui_width();
    var text = "Anchor Cooldown: " + string(ceil(anchorCooldown)) + "s";
    
    draw_set_color(c_yellow);
    draw_set_halign(fa_right);
    draw_text(guiW - 20, 20, text);
    
    // Reset alignment back to left so it doesn't break other UI elements
    draw_set_halign(fa_left);
}

if (isAnchorAiming && (!instance_exists(oScenes) || !oScenes.active)) {
    var aimX = device_mouse_x_to_gui(0);
    var aimY = device_mouse_y_to_gui(0);

    draw_set_color(c_aqua);
    draw_circle_color(aimX, aimY, 14, c_aqua, c_aqua, true);
    draw_line_color(aimX - 20, aimY, aimX - 6, aimY, c_aqua, c_aqua);
    draw_line_color(aimX + 6, aimY, aimX + 20, aimY, c_aqua, c_aqua);
    draw_line_color(aimX, aimY - 20, aimX, aimY - 6, c_aqua, c_aqua);
    draw_line_color(aimX, aimY + 6, aimX, aimY + 20, c_aqua, c_aqua);
}