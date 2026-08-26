var guiW = display_get_gui_width();
var guiH = display_get_gui_height();

// --- [E] prompt when in range and shop closed ---
if (!shopOpen && instance_exists(oPlayer) && point_distance(x, y, oPlayer.x, oPlayer.y) < interactRadius) {
    var cam = view_camera[0];
    var scaleX = guiW / camera_get_view_width(cam);
    var scaleY = guiH / camera_get_view_height(cam);
    var screenX = (x - camera_get_view_x(cam)) * scaleX;
    var screenY = (y - camera_get_view_y(cam) - sprite_height - 10) * scaleY;
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text(screenX, screenY, "[E]");
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// --- Full shop UI ---
if (shopOpen) {
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    var clicked = mouse_check_button_pressed(mb_left);
    
    var panelW = 340;
    var panelH = 340;
    var panelX = (guiW / 2) - (panelW / 2);
    var panelY = (guiH / 2) - (panelH / 2);
    
    draw_rectangle_color(panelX, panelY, panelX + panelW, panelY + panelH, c_black, c_black, c_black, c_black, false);
    
    var tabY = panelY + 10;
    
    draw_set_color(shopTab == "items" ? c_yellow : c_white);
    draw_text(panelX + 20, tabY, "Items");
    if (point_in_rectangle(mx, my, panelX + 20, tabY, panelX + 100, tabY + 20) && clicked) shopTab = "items";
    
    draw_set_color(shopTab == "upgrades" ? c_yellow : c_white);
    draw_text(panelX + 120, tabY, "Upgrades");
    if (point_in_rectangle(mx, my, panelX + 120, tabY, panelX + 200, tabY + 20) && clicked) shopTab = "upgrades";
    
    var contentX = panelX + 20;
    var contentY = tabY + 30;
    
    if (shopTab == "items") {
        var upW = panelW - 40;
        var upH = 110;
        
        var canAffordFalo = hasItemAmount(global.itemOak, 3) && hasItemAmount(global.itemBirch, 3) && hasItemAmount(global.itemMaple, 3)
            && hasItemAmount(global.itemCoal, 3) && hasItemAmount(global.itemGold, 3) && hasItemAmount(global.itemIron, 3)
            && hasItemAmount(global.itemShard, 3);
        
        var faloCostLines = [
            "Cost:",
            "3 Maple, 3 Birch, 3 Oak",
            "3 Gold, 3 Iron, 3 Coal",
            "3 Enemy Shards"
        ];
        
        if (drawUpgradeBlock(contentX, contentY, upW, upH, "Falo", faloCostLines, canAffordFalo, faloBought, mx, my, clicked)) {
            removeItemAmount(global.itemOak, 3);
            removeItemAmount(global.itemBirch, 3);
            removeItemAmount(global.itemMaple, 3);
            removeItemAmount(global.itemCoal, 3);
            removeItemAmount(global.itemGold, 3);
            removeItemAmount(global.itemIron, 3);
            removeItemAmount(global.itemShard, 3);
            faloBought = true;
        }
        
        var faloScale = 2.5; // tune until it looks right against the block size
        var faloSpriteX = contentX + upW - 40;
        var faloSpriteY = contentY + upH/2;
        draw_sprite_ext(global.itemFalo.sprite, 0, faloSpriteX, faloSpriteY, faloScale, faloScale, 0, c_white, 1);

    }
    else if (shopTab == "upgrades") {
        var upW = panelW - 40;
        var upH = 44;
        var spacing = 8;
        var upY = contentY;
        
        // --- Sharper Axe ---
        var canAffordAxe = hasItemAmount(global.itemOak, 1) && hasItemAmount(global.itemBirch, 1) && hasItemAmount(global.itemMaple, 1);
        var axeCostLines = ["Cost: 1 oak, 1 birch, 1 maple"];
        if (drawUpgradeBlock(contentX, upY, upW, upH, "Sharper Axe (-2 tree hits)", axeCostLines, canAffordAxe, axeUpgradeBought, mx, my, clicked)) {
            removeItemAmount(global.itemOak, 1);
            removeItemAmount(global.itemBirch, 1);
            removeItemAmount(global.itemMaple, 1);
            with (oTree) {
                treeHealth = max(1, treeHealth - 2);
                treeHealthMax = max(1, treeHealthMax - 2);
            }
            axeUpgradeBought = true;
        }
        upY += upH + spacing;
        
        // --- Sharper Pickaxe ---
        var canAffordPickaxe = hasItemAmount(global.itemCoal, 1) && hasItemAmount(global.itemGold, 1) && hasItemAmount(global.itemIron, 1);
        var pickaxeCostLines = ["Cost: 1 coal, 1 gold, 1 iron"];
        if (drawUpgradeBlock(contentX, upY, upW, upH, "Sharper Pickaxe (-2 ore hits)", pickaxeCostLines, canAffordPickaxe, pickaxeUpgradeBought, mx, my, clicked)) {
            removeItemAmount(global.itemCoal, 1);
            removeItemAmount(global.itemGold, 1);
            removeItemAmount(global.itemIron, 1);
            with (oMineral) {
                mineralHealth = max(1, mineralHealth - 2);
                mineralHealthMax = max(1, mineralHealthMax - 2);
            }
            pickaxeUpgradeBought = true;
        }
        upY += upH + spacing;
        
        // --- Sharper Blade ---
        var canAffordDamage = hasItemAmount(global.itemShard, 1);
        var damageCostLines = ["Cost: 1 shard"];
        if (drawUpgradeBlock(contentX, upY, upW, upH, "Sharper Blade (+5 damage)", damageCostLines, canAffordDamage, damageUpgradeBought, mx, my, clicked)) {
            removeItemAmount(global.itemShard, 1);
            oPlayer.attackDamage += 5;
            damageUpgradeBought = true;
        }
    }
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}