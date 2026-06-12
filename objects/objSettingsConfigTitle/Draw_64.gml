draw_set_font(global.fonteTitulo);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var base_x = gui_w * 0.06;
var y_title = gui_h * 0.12;
draw_set_colour(c_white);
draw_text(base_x, y_title, "SETTINGS");