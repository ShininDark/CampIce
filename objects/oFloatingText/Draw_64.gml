if (mode == "flyToHud") {
    var t = clamp(flyTimer / flyDuration, 0, 1);
    var easedT = t * t;
    
    var cam = view_camera[0];
    var guiW = display_get_gui_width();
    var guiH = display_get_gui_height();
    var scaleX = guiW / camera_get_view_width(cam);
    var scaleY = guiH / camera_get_view_height(cam);
    var startGuiX = (startWorldX - camera_get_view_x(cam)) * scaleX;
    var startGuiY = (startWorldY - camera_get_view_y(cam)) * scaleY;
    
    var curX = lerp(startGuiX, targetGuiX, easedT);
    var curY = lerp(startGuiY, targetGuiY, easedT);
    
    draw_set_color(color);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_transformed(curX, curY, text, 1.5, 1.5, 0);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}