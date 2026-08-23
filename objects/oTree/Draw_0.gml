draw_self();

if (isMining) {
    var barW = 32;
    var barH = 5;
    var barX = x - barW/2;
    var barY = y - sprite_height/2 - 12;
    
    var pct = 1 - (treeHealth / treeHealthMax);
    
    draw_rectangle_color(barX, barY, barX + barW, barY + barH, c_black, c_black, c_black, c_black, false);
    draw_rectangle_color(barX, barY, barX + (barW * pct), barY + barH, c_lime, c_lime, c_lime, c_lime, false);
}