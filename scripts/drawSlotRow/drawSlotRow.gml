function drawSlotRow(slotArray, startX, startY, slotSize, slotGap) {
    draw_set_halign(fa_right);
    draw_set_valign(fa_bottom);
    for (var i = 0; i < array_length(slotArray); i++) {
        var slotX = startX + i * (slotSize + slotGap);
        draw_rectangle_color(slotX, startY, slotX + slotSize, startY + slotSize, c_gray, c_gray, c_gray, c_gray, false);
        var item = slotArray[i];
        if (item != noone) {
            draw_sprite_stretched(item.sprite, 0, slotX, startY, slotSize, slotSize);
            draw_set_color(c_white);
            draw_text(slotX + slotSize - 2, startY + slotSize - 2, string(item.count));
        }
    }
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}