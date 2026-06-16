draw_self();
if (!ja_falou) {
    draw_set_color(c_white);
    draw_rectangle(x - 12, y - 45, x + 12, y - 25, false);
    
    draw_set_color(c_black);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(x, y - 35, "?");
}