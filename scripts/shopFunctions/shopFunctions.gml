// Returns true if hotbar + inventory combined hold at least `amount` of itemDef.
function hasItemAmount(itemDef, amount) {
    var total = 0;
    var arrays = [oInventory.hotbar, oInventory.inventory];
    for (var a = 0; a < 2; a++) {
        var arr = arrays[a];
        for (var i = 0; i < array_length(arr); i++) {
            if (arr[i] != noone && arr[i].itemId == itemDef.itemId) {
                total += arr[i].count;
            }
        }
    }
    return total >= amount;
}

// Removes `amount` of itemDef from hotbar/inventory. Call hasItemAmount() first.
function removeItemAmount(itemDef, amount) {
    var remaining = amount;
    var arrays = [oInventory.hotbar, oInventory.inventory];
    for (var a = 0; a < 2; a++) {
        var arr = arrays[a];
        for (var i = 0; i < array_length(arr); i++) {
            if (arr[i] != noone && arr[i].itemId == itemDef.itemId) {
                var take = min(remaining, arr[i].count);
                arr[i].count -= take;
                remaining -= take;
                if (arr[i].count <= 0) arr[i] = noone;
                if (remaining <= 0) return;
            }
        }
    }
}

// Draws one upgrade as a bordered block. costLines is an array of strings,
// each drawn on its own line below the title. Returns true only if it was
// clicked while affordable and not already purchased.
function drawUpgradeBlock(bx, by, bw, bh, title, costLines, canAfford, purchased, mx, my, clicked) {
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    var bg = purchased ? c_dkgray : c_gray;
    draw_rectangle_color(bx, by, bx + bw, by + bh, bg, bg, bg, bg, false);
    
    var hovered = point_in_rectangle(mx, my, bx, by, bx + bw, by + bh);
    var borderColor = (hovered && !purchased) ? c_yellow : c_white;
    draw_rectangle_color(bx, by, bx + bw, by + bh, borderColor, borderColor, borderColor, borderColor, true);
    
    var textColor = purchased ? c_ltgray : (canAfford ? c_white : c_red);
    draw_set_color(textColor);
    draw_text(bx + 8, by + 6, title);
    
    var lineY = by + 24;
    for (var i = 0; i < array_length(costLines); i++) {
        draw_text(bx + 8, lineY, costLines[i]);
        lineY += 16;
    }
    
    if (purchased) {
        draw_set_color(c_lime);
        draw_set_halign(fa_right);
        draw_text(bx + bw - 8, by + 6, "Purchased");
        draw_set_halign(fa_left);
    }
    
    return (!purchased && canAfford && hovered && clicked);
}