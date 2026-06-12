draw_set_font(global.fonteNormal);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

var base_x = gui_w * 0.06;
var y_se = gui_h * 0.42;

var txt_se = "SETTINGS";
var w_se = string_width(txt_se);
var h_se = string_height(txt_se);

if (mx >= base_x && mx <= base_x + w_se && my >= y_se && my <= y_se + h_se) {
    draw_set_colour($4c00ff);
    if (mouse_check_button_pressed(mb_left)) {
        room_goto(rm_settings); 
    }
} else {
    draw_set_colour(c_white);
}

draw_text(base_x, y_se, txt_se);
draw_set_colour(c_white);