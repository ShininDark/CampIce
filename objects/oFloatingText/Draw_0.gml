var alpha = 1 - (timer / lifeTime); // fade out over its lifetime
draw_set_alpha(alpha);
draw_set_color(color);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(x, y, text);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);