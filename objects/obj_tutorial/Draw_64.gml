draw_set_font(global.fonteNormal);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

var base_x = gui_w * 0.06;
var start_y = gui_h * 0.15;
var spacing = gui_h * 0.08;

draw_set_colour($4c00ff);
draw_text(base_x, start_y, "HOW TO PLAY");

draw_set_font(global.fonteNM);
draw_set_colour(c_white);
draw_text(base_x, start_y + spacing, "A / D or LEFT / RIGHT ARROWS - MOVE");

draw_set_font(global.fonteNormal);
draw_set_colour($4c00ff);
draw_text(base_x, start_y + spacing * 2.4, "ACTIONS");

draw_set_font(global.fonteNM);
draw_set_colour(c_white);
draw_text(base_x, start_y + spacing * 3.4, "SPACEBAR - JUMP");
draw_text(base_x, start_y + spacing * 4.2, "SHIFT - RUN (CONSUMES SANITY)");
draw_text(base_x, start_y + spacing * 5.0, "E - INTERACT / TAKE PILLS");

var y_bk = start_y + spacing * 7.5;
draw_set_font(global.fonteNormal);

var txt_bk = "START GAME";
var w_bk = string_width(txt_bk);
var h_bk = string_height(txt_bk);

if (mx >= base_x && mx <= base_x + w_bk && my >= y_bk && my <= y_bk + h_bk) {
    draw_set_colour($4c00ff);
    window_set_cursor(cr_handpoint);
    if (mouse_check_button_pressed(mb_left)) {
        room_goto(rm_game); 
    }
} else {
    draw_set_colour(c_white);
    window_set_cursor(cr_default);
}

draw_text(base_x, y_bk, txt_bk);
draw_set_colour(c_white);