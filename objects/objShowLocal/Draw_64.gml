var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var margin = 40;
var base_x = gui_w / 2;
var base_y = gui_h - margin;
draw_set_alpha(alpha * 0.70);
draw_set_color(c_black);
draw_rectangle(0, base_y - 100, gui_w, gui_h, false);
draw_set_alpha(1);
draw_set_alpha(alpha);

var x_pos = base_x + slide_offset;
if (shadow) {
    draw_set_color(c_black);
    draw_set_alpha(alpha * 0.4);
    draw_set_font(global.fonteNormal);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_text(x_pos + 4, base_y + 4, text);
    draw_set_alpha(1);
}

draw_set_color(color);
draw_set_alpha(alpha);
draw_set_font(global.fonteNormal);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_text(x_pos, base_y, text);
if (chapter_number >= 0) {
    draw_set_font(global.fonteNormal);
    draw_set_color(c_white);
    draw_set_alpha(alpha * 0.7);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_text(x_pos, base_y - 40, "CHAPTER " + string(chapter_number));
}

draw_set_alpha(1);