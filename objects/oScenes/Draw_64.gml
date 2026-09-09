if (active) {
    var guiW = display_get_gui_width();
    var guiH = display_get_gui_height();
    
    var currentScene = scenes[sceneIndex];
    
    // --- FAST PUSH-IN TO CLEAN ZOOM-OUT FOR CAMP ICE ---
    if (currentScene.image == sEndCampIce) {
        if (!variable_instance_exists(id, "camZoomTimer")) camZoomTimer = 0;
        camZoomTimer += delta_time / 1000000;
        
        // Correct aspect ratio scale to prevent squishing
        var baseScale = guiH / sprite_get_height(currentScene.image);
        
        // Progress tracking (0.0 to 1.0 over ~3 seconds)
        var progress = min(camZoomTimer / 3.0, 1.0);
        
        // Smooth snap: Starts zoomed-in close on the center courtyard (1.5x), then pulls out smoothly to full view (1.0x)
        var zoomCurve = power(1 - progress, 2); // Fast start, smooth deceleration
        var zoom = 1.0 + (0.5 * zoomCurve); 
        
        var drawW = sprite_get_width(currentScene.image) * baseScale * zoom;
        var drawH = sprite_get_height(currentScene.image) * baseScale * zoom;
        
        // Center the camera cleanly without back-and-forth side shaking
        var drawX = (guiW - drawW) / 2;
        var drawY = (guiH - drawH) / 2;
        
        draw_sprite_stretched(currentScene.image, 0, drawX, drawY, drawW, drawH);
    } else {
        camZoomTimer = 0; // Reset timer for other scenes
        draw_sprite_stretched(currentScene.image, 0, 0, 0, guiW, guiH);
    }
    
    // --- CINEMATIC LETTERBOXING (Top and bottom dark bars) ---
    if (currentScene.image != sEndBlack) {
        draw_set_color(c_black);
        draw_set_alpha(0.5);
        draw_rectangle(0, 0, guiW, 35, false);
        draw_rectangle(0, guiH - 35, guiW, guiH, false);
        draw_set_alpha(1.0);
    }

    if (fadeState == "none") {
        if (currentScene.image == sEndBlack) {
            // --- "CAMPICE: THE END" TITLE CARD ---
            var pulse = 1 + (sin(current_time * 0.002) * 0.04);
            var centerX = guiW / 2;
            var centerY = guiH / 2;
            
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            
            var titleScale = 4.5 * pulse;
            var subtitleScale = 2.0 * pulse;
            
            // Outer drop shadows
            draw_set_color(c_dkgray);
            draw_text_transformed(centerX + 4, centerY - 60 + 4, "CAMPICE", titleScale, titleScale, 0);
            draw_text_transformed(centerX - 2, centerY - 60 - 2, "CAMPICE", titleScale, titleScale, 0);
            
            // Main white title
            draw_set_color(c_white);
            draw_text_transformed(centerX, centerY - 60, "CAMPICE", titleScale, titleScale, 0);
            
            // Red subtitle shadow & text
            draw_set_color(c_black);
            draw_text_transformed(centerX + 3, centerY + 50 + 3, "T H E   E N D", subtitleScale, subtitleScale, 0);
            
            draw_set_color(c_red);
            draw_text_transformed(centerX, centerY + 50, "T H E   E N D", subtitleScale, subtitleScale, 0);
            
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
        } else {
            // --- DIALOGUE BOX ---
            var boxW = guiW - 80;
            var boxH = 100;
            var boxX = 40;
            var boxY = guiH - boxH - 30;
            
            draw_set_alpha(0.85);
            draw_rectangle_color(boxX, boxY, boxX + boxW, boxY + boxH, c_black, c_black, c_black, c_black, false);
            draw_set_alpha(1.0);
            
            draw_rectangle_color(boxX, boxY, boxX + boxW, boxY + boxH, c_white, c_white, c_white, c_white, true);
            
            draw_set_color(c_white);
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
            var visibleText = string_copy(currentScene.lines[lineIndex], 1, typedChars);
            draw_text_ext(boxX + 16, boxY + 16, visibleText, -1, boxW - 32);
            
            var alphaPrompt = 0.5 + (sin(current_time * 0.008) * 0.5);
            draw_set_alpha(alphaPrompt);
            draw_set_halign(fa_right);
            draw_set_valign(fa_bottom);
            draw_text(boxX + boxW - 12, boxY + boxH - 8, "[E] continue >");
            draw_set_alpha(1.0);
            
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
        }
    }
    
    // Transition fade overlay
    if (fadeAlpha > 0) {
        draw_set_alpha(fadeAlpha);
        draw_rectangle_color(0, 0, guiW, guiH, c_black, c_black, c_black, c_black, false);
        draw_set_alpha(1.0);
    }
}