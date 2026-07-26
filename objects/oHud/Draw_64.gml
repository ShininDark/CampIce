// Draw GUI Event, oHud
var slotSize = 48;
var slotGap = 4;
var startX = 20;
var startY = 100;

for (var i = 0; i < array_length(oGlobal.inventory); i++) {
    var item = oGlobal.inventory[i];
    var slotX = startX + (i * (slotSize + slotGap));
    var slotY = startY;

    draw_rectangle_color(slotX, slotY, slotX + slotSize, slotY + slotSize, c_gray, c_gray, c_gray, c_gray, false);
    draw_sprite_stretched(item.sprite, 0, slotX, slotY, slotSize, slotSize);

    // count badge, bottom-right corner of the slot
    draw_set_color(c_white);
    draw_set_halign(fa_right);
    draw_set_valign(fa_bottom);
    draw_text(slotX + slotSize - 2, slotY + slotSize - 2, string(item.count));
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);