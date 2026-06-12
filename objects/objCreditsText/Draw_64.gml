draw_set_font(global.fonteNormal);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var base_x = gui_w * 0.06;
var y_title = gui_h * 0.15;
var start_y = gui_h * 0.28;
var spacing = gui_h * 0.06;

draw_set_colour($4c00ff);
draw_text(base_x, start_y, "MAIN PROGRAMMER");
draw_set_font(global.fonteNM);
draw_set_colour(c_white);
draw_text(base_x, start_y + spacing, "Lucas Eduardo");
draw_set_colour($4c00ff);
draw_set_font(global.fonteNormal);
draw_text(base_x, start_y + spacing*2.4, "MUSICS");
draw_set_font(global.fonteNM);
draw_set_colour(c_white);
draw_text(base_x, start_y + spacing*3.4, "Lucas Eduardo");
draw_set_font(global.fonteNormal);
draw_set_colour($4c00ff);
draw_text(base_x, start_y + spacing*4.8, "LEVEL DESIGN");
draw_set_font(global.fonteNM);
draw_set_colour(c_white);
draw_text(base_x, start_y + spacing*5.8, "Isabella Sanches");

draw_set_colour(c_white);

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

var y_bk = start_y + spacing * 9;

draw_set_font(global.fonteNormal);

var txt_bk = "BACK TO MAIN MENU";
var w_bk = string_width(txt_bk);
var h_bk = string_height(txt_bk);

if (mx >= base_x && mx <= base_x + w_bk && my >= y_bk && my <= y_bk + h_bk) {
    draw_set_colour($4c00ff);
    if (mouse_check_button_pressed(mb_left)) {
        room_goto(rm_menu); 
    }
} else {
    draw_set_colour(c_white);
}

draw_text(base_x, y_bk, txt_bk);
draw_set_colour(c_white);


