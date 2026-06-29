var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var base_x = gui_w / 2;
var base_y = gui_h / 2;

draw_set_alpha(draw_alpha);

if (shadow) {
    draw_set_color(c_black);
    draw_set_alpha(draw_alpha * 0.6);
    draw_text(base_x + 4, base_y + 4, text);
}

draw_set_color(color);
draw_set_alpha(draw_alpha);
draw_set_font(global.fonteTitulo2);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(base_x, base_y, text);

if (show_chapter) {
    draw_set_font(global.fonteTitulo);
    draw_set_color(c_white);
    draw_set_alpha(draw_alpha * 0.7);
    draw_text(base_x, base_y + 80, "CHAPTER " + string(global.current_chapter));
}

draw_set_alpha(1);