draw_self();

var flutuar = sin(current_time * 0.005) * 4;
var bx = x;
var by = y - 45 + flutuar;

if (tipo == "normal" && !ja_falou) {
    draw_set_color(c_black);
    draw_roundrect_ext(bx - 12, by - 14, bx + 12, by + 10, 6, 6, false);
    draw_triangle(bx - 4, by + 9, bx + 4, by + 9, bx, by + 15, false);
    
    draw_set_color(make_color_rgb(255, 200, 0));
    draw_roundrect_ext(bx - 10, by - 12, bx + 10, by + 8, 4, 4, false);
    draw_triangle(bx - 3, by + 7, bx + 3, by + 7, bx, by + 13, false);
    
    draw_set_font(global.fonteNormal);
    draw_set_color(c_black);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(bx, by - 1, "!");
}

if (tipo == "comerciante" && !vendido) {
    draw_set_color(c_black);
    draw_roundrect_ext(bx - 12, by - 14, bx + 12, by + 10, 6, 6, false);
    draw_triangle(bx - 4, by + 9, bx + 4, by + 9, bx, by + 15, false);
    
    draw_set_color(make_color_rgb(0, 210, 90));
    draw_roundrect_ext(bx - 10, by - 12, bx + 10, by + 8, 4, 4, false);
    draw_triangle(bx - 3, by + 7, bx + 3, by + 7, bx, by + 13, false);
    
    draw_set_font(global.fonteNormal);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(bx, by - 1, "$");
}

if (tipo == "comerciante" && vendido) {
    draw_set_color(c_black);
    draw_roundrect_ext(bx - 12, by - 14, bx + 12, by + 10, 6, 6, false);
    draw_triangle(bx - 4, by + 9, bx + 4, by + 9, bx, by + 15, false);
    
    draw_set_color(make_color_rgb(70, 70, 70));
    draw_roundrect_ext(bx - 10, by - 12, bx + 10, by + 8, 4, 4, false);
    draw_triangle(bx - 3, by + 7, bx + 3, by + 7, bx, by + 13, false);
    
    draw_set_font(global.fonteNormal);
    draw_set_color(make_color_rgb(150, 150, 150));
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(bx, by - 1, "x");
}