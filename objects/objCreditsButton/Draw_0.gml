draw_set_font(global.fonteNormal);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

var base_x = gui_w * 0.06;
var y_cr = gui_h * 0.49;

var txt_cr = "CREDITS";
var w_cr = string_width(txt_cr);
var h_cr = string_height(txt_cr);

if (mx >= base_x && mx <= base_x + w_cr && my >= y_cr && my <= y_cr + h_cr) {
    draw_set_colour($4c00ff);
    if (mouse_check_button_pressed(mb_left)) {
        room_goto(rm_credits); 
    }
} else {
    draw_set_colour(c_white);
}

draw_text(base_x, y_cr, txt_cr);
draw_set_colour(c_white);