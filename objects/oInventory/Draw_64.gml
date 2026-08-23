var slotScale = 2;
var slotSize = sprite_get_width(sInvSlot) * slotScale;
slotPad = slotSize + 2;
var guiW = display_get_gui_width();
var guiH = display_get_gui_height();

// --- Hotbar: always drawn, bottom center ---
var hbW = hotbarSize * slotPad - 2;
var hbX = (guiW / 2) - (hbW / 2);
var hbY = guiH - slotSize - 20;

for (var i = 0; i < hotbarSize; i++) {
    var slotX = hbX + i * slotPad;
    var slotY = hbY;
    
    draw_sprite_ext(sInvSlot, 0, slotX, slotY, slotScale, slotScale, 0, c_white, 1);
    
    var item = hotbar[i];
    if (item != noone) {
        var spr = item.sprite;
        draw_sprite_ext(spr, 0, slotX, slotY, slotScale, slotScale, 0, c_white, 1);
        
        var amt = item.count;
        if (amt > 1) {
            draw_set_halign(fa_right);
            draw_set_valign(fa_bottom);
            draw_text_transformed(slotX + slotSize/2 - 4, slotY + slotSize/2 - 4, amt, 0.8, 0.8, 0);
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
        }
    }
}

// --- Full inventory grid: only when open, centered on screen ---
if (invOpen) {
    var gridW = invWidth * slotPad - 2;
    var gridH = invHeight * slotPad - 2;
    var gridX = (guiW / 2) - (gridW / 2);
    var gridY = (guiH / 2) - (gridH / 2);
    
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    
    for (var i = 0; i < invTotal; i++) {
        var col = i mod invWidth;
        var row = i div invWidth;
        var xx = gridX + col * slotPad;
        var yy = gridY + row * slotPad;
        
        // hover scale
        var isHover = point_in_rectangle(mx, my, xx - slotSize/2, yy - slotSize/2, xx + slotSize/2, yy + slotSize/2);
        if (isHover) {
            invAnims[i].size = lerp(invAnims[i].size, 1.1, 0.2);
        } else {
            invAnims[i].size = lerp(invAnims[i].size, 1, 0.2);
        }
        var sizeMod = invAnims[i].size;
        
        draw_sprite_ext(sInvSlot, 0, xx, yy, sizeMod * slotScale, sizeMod * slotScale, 0, c_white, 1);
        
        var item = inventory[i];
        if (item != noone) {
            draw_sprite_ext(item.sprite, 0, xx, yy, sizeMod * slotScale, sizeMod * slotScale, 0, c_white, 1);
            
            var amt = item.count;
            if (amt > 1) {
                draw_set_halign(fa_right);
                draw_set_valign(fa_bottom);
                draw_text_transformed(xx + slotSize/2 - 4, yy + slotSize/2 - 4, amt, 0.8*sizeMod, 0.8*sizeMod, 0);
                draw_set_halign(fa_left);
                draw_set_valign(fa_top);
            }
        }
    }
}