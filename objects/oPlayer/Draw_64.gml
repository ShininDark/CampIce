if (anchorCooldown > 0 && (!instance_exists(oScenes) || !oScenes.active)) {
    var guiW = display_get_gui_width();
    var text = "Anchor Cooldown: " + string(ceil(anchorCooldown)) + "s";
    
    draw_set_color(c_yellow);
    draw_set_halign(fa_right);
    draw_text(guiW - 20, 20, text);
    draw_set_halign(fa_left);
}