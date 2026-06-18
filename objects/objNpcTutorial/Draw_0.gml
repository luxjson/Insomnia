draw_self();

if (tipo == "normal" && !ja_falou) {
    draw_set_color(c_yellow);
    draw_rectangle(x - 15, y - 55, x + 15, y - 25, false);
    draw_set_font(global.fonteNormal);
    draw_set_color(c_black);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(x, y - 35, "!");
}

if (tipo == "comerciante" && !vendido) {
    draw_set_color(c_yellow);
    draw_rectangle(x - 15, y - 55, x + 15, y - 25, false);
    draw_set_font(global.fonteNormal);
    draw_set_color(c_black);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(x, y - 35, "!");
}

if (tipo == "comerciante" && vendido) {
    draw_set_color(c_gray);
    draw_rectangle(x - 15, y - 55, x + 15, y - 25, false);
    draw_set_font(global.fonteNormal);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(x, y - 35, "!");
}