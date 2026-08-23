if (isLit && instance_exists(oPlayer) && point_distance(x, y, oPlayer.x, oPlayer.y) < interactRadius) {
    var cam = view_camera[0];
    var camX = camera_get_view_x(cam);
    var camY = camera_get_view_y(cam);
    var camW = camera_get_view_width(cam);
    var camH = camera_get_view_height(cam);
    
    var guiW = display_get_gui_width();
    var guiH = display_get_gui_height();
    
    var scaleX = guiW / camW;
    var scaleY = guiH / camH;
    
    var screenX = (x - camX) * scaleX;
    var screenY = (y - camY - sprite_height - 10) * scaleY;
    
    if (!isHolding) {
        // simple prompt
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(c_white);
        draw_text(screenX, screenY, "[E]");
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
    else {
        // radial hold progress
        var radius = 14;
        var pct = clamp(holdTimer / holdDuration, 0, 1);
        
        // black background circle
        draw_circle_color(screenX, screenY, radius, c_black, c_black, false);
        
        // purple fill using an arc built from triangles (GameMaker has no native pie-slice draw)
        var segments = 36;
        var angleStep = 360 / segments;
        var fillSegments = floor(segments * pct);
        
        for (var i = 0; i < fillSegments; i++) {
            var a1 = 90 - (i * angleStep);       // start at top, go clockwise
            var a2 = 90 - ((i + 1) * angleStep);
            var x1 = screenX + lengthdir_x(radius, a1);
            var y1 = screenY - lengthdir_y(radius, a1);
            var x2 = screenX + lengthdir_x(radius, a2);
            var y2 = screenY - lengthdir_y(radius, a2);
            
            draw_triangle_color(screenX, screenY, x1, y1, x2, y2, c_purple, c_purple, c_purple, false);
        }
    }
}