draw_set_alpha(alpha);
draw_set_font(global.fonteNormal);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(color);
draw_text_transformed(xx, yy, text, scale, scale, 0);
draw_set_alpha(1);