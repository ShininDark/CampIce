if (active) {
    var guiW = display_get_gui_width();
    var guiH = display_get_gui_height();
    
    var boxW = guiW - 80;
    var boxH = 100;
    var boxX = 40;
    var boxY = guiH - boxH - 30;
    
    draw_rectangle_color(boxX, boxY, boxX + boxW, boxY + boxH, c_black, c_black, c_black, c_black, false);
    draw_rectangle_color(boxX, boxY, boxX + boxW, boxY + boxH, c_white, c_white, c_white, c_white, true);
    
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text_ext(boxX + 16, boxY + 16, lines[lineIndex], -1, boxW - 32);
    
    draw_set_halign(fa_right);
    draw_set_valign(fa_bottom);
    draw_text(boxX + boxW - 12, boxY + boxH - 8, "[E] continue");
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}