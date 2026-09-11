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
        
        var woodTypes = [global.itemOak, global.itemBirch, global.itemMaple];
        var oreTypes = [global.itemCoal, global.itemGold, global.itemIron];
        
        var canAffordFalo = hasAnyOf(woodTypes, 1) && hasAnyOf(oreTypes, 1) && hasItemAmount(global.itemShard, 1);
        
        var faloCostLines = [
            "Cost:",
            "1 Wood (any type)",
            "1 Ore (any type)",
            "1 Enemy Shard"
        ];
        
        if (drawUpgradeBlock(contentX, contentY, upW, upH, "Falo", faloCostLines, canAffordFalo, faloBought, mx, my, clicked)) {
            playSfx(sndPurchase);
            removeAnyOf(woodTypes, 1);
            removeAnyOf(oreTypes, 1);
            removeItemAmount(global.itemShard, 1);
            faloBought = true;
            
            playMusic(sndMenuMusic);
            
            var sceneArr = [
                // 1. EXISTING sEnd1
                { image: sEnd1, lines: ["You hand over the last of your supplies."] },

                // 2. EXISTING sEnd2
                { image: sEnd2, lines: ["Falo starts behaving out of the ordinary..."] },

                // 3. EXISTING sEnd3
                { image: sEnd3, lines: ["Falo takes over your mind, and everything goes silent."] },

                // 4. NEW sEndCampIce
                { image: sEndCampIce, lines: ["For a moment, everything is quiet."] },

                // 5. NEW sEndCampIce
                { image: sEndCampIce, lines: ["The place you fought so hard to survive is still standing."] },

                // 6. NEW sEndLunatic
                { image: sEndLunatic, lines: ["Lunatic: You came here looking for a way out."] },

                // 7. NEW sEndLunatic
                { image: sEndLunatic, lines: ["Lunatic: But CampIce had other plans."] },

                // 8. NEW sEndLunatic
                { image: sEndLunatic, lines: ["Lunatic: Now... it's your turn to stay."] },

                // 9. NEW sEndCampIce
                { image: sEndCampIce, lines: ["You survived CampIce."] },

                // 10. NEW sEndBlack
                { image: sEndBlack, lines: ["CAMPICE\n\nTHE END"] }
            ];
            
            startSceneSequence(sceneArr, function() {
                game_restart();
            });
        }

        var faloScale = 2.5;
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
        var woodTypesUp = [global.itemOak, global.itemBirch, global.itemMaple];
        var canAffordAxe = hasAnyOf(woodTypesUp, 1);
        var axeCostLines = ["Cost: 1 wood (any type)"];
        if (drawUpgradeBlock(contentX, upY, upW, upH, "Sharper Axe (-2 tree hits)", axeCostLines, canAffordAxe, axeUpgradeBought, mx, my, clicked)) {
            playSfx(sndPurchase);
            removeAnyOf(woodTypesUp, 1);
            with (oTree) {
                treeHealth = max(1, treeHealth - 2);
                treeHealthMax = max(1, treeHealthMax - 2);
            }
            axeUpgradeBought = true;
            if (global.questStage == 100) {
                global.questUpgradesBought = min(global.questUpgradesBought + 1, global.questUpgradesTarget);
            }
        }
        upY += upH + spacing;
        
        // --- Sharper Pickaxe ---
        var oreTypesUp = [global.itemCoal, global.itemGold, global.itemIron];
        var canAffordPickaxe = hasAnyOf(oreTypesUp, 1);
        var pickaxeCostLines = ["Cost: 1 ore (any type)"];
        
        if (drawUpgradeBlock(contentX, upY, upW, upH, "Sharper Pickaxe (-2 ore hits)", pickaxeCostLines, canAffordPickaxe, pickaxeUpgradeBought, mx, my, clicked)) {
            playSfx(sndPurchase);
            removeAnyOf(oreTypesUp, 1);
            with (oMineral) {
                mineralHealth = max(1, mineralHealth - 2);
                mineralHealthMax = max(1, mineralHealthMax - 2);
            }
            pickaxeUpgradeBought = true;
            if (global.questStage == 100) {
                global.questUpgradesBought = min(global.questUpgradesBought + 1, global.questUpgradesTarget);
            }
        }
        upY += upH + spacing;
        
        // --- Sharper Blade ---
        var canAffordDamage = hasItemAmount(global.itemShard, 1);
        var damageCostLines = ["Cost: 1 shard"];
        if (drawUpgradeBlock(contentX, upY, upW, upH, "Sharper Blade (+5 damage)", damageCostLines, canAffordDamage, damageUpgradeBought, mx, my, clicked)) {
            playSfx(sndPurchase);
            removeItemAmount(global.itemShard, 1);
            oPlayer.attackDamage += 5;
            damageUpgradeBought = true;
            if (global.questStage == 100) {
                global.questUpgradesBought = min(global.questUpgradesBought + 1, global.questUpgradesTarget);
            }
        }
    }
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}