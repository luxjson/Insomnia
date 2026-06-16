draw_set_font(global.fonteNormal);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

var base_x = gui_w * 0.06;
var start_y = gui_h * 0.30;
var spacing = gui_h * 0.09;

var txt_fs = "FULLSCREEN: " + (fullscreen ? "ON" : "OFF");
var w_fs = string_width(txt_fs);
var h_fs = string_height(txt_fs);
var y_fs = start_y;

if (mx >= base_x && mx <= base_x + w_fs && my >= y_fs && my <= y_fs + h_fs) {
    draw_set_colour($4c00ff);
    if (mouse_check_button_pressed(mb_left)) {
        fullscreen = !fullscreen;
        window_set_fullscreen(fullscreen);
        
        ini_open("configuracoes.ini");
        ini_write_real("Video", "Fullscreen", fullscreen);
        ini_close();
        
        alarm[11] = 2;
    }
} else {
    draw_set_colour(c_white);
}
draw_text(base_x, y_fs, txt_fs);

var txt_au = "AUDIO: " + string(round(audio_volume * 100)) + "%";
var w_au = string_width(txt_au);
var h_au = string_height(txt_au);
var y_au = start_y + spacing;

if (mx >= base_x && mx <= base_x + w_au && my >= y_au && my <= y_au + h_au) {
    draw_set_colour($4c00ff);
    if (mouse_check_button_pressed(mb_left)) {
        audio_volume += 0.1;
        if (audio_volume > 1.05) audio_volume = 0;
        audio_master_gain(audio_volume);
        
        ini_open("configuracoes.ini");
        ini_write_real("Audio", "Volume", audio_volume);
        ini_close();
    }
} else {
    draw_set_colour(c_white);
}
draw_text(base_x, y_au, txt_au);

var txt_ac = "ACHIEVEMENTS: " + (achievements_enabled ? "ENABLED" : "DISABLED");
var w_ac = string_width(txt_ac);
var h_ac = string_height(txt_ac);
var y_ac = start_y + (spacing * 2);

if (mx >= base_x && mx <= base_x + w_ac && my >= y_ac && my <= y_ac + h_ac) {
    draw_set_colour($4c00ff);
    if (mouse_check_button_pressed(mb_left)) {
        achievements_enabled = !achievements_enabled;
        
        ini_open("configuracoes.ini");
        ini_write_real("Gameplay", "Achievements", achievements_enabled);
        ini_close();
    }
} else {
    draw_set_colour(c_white);
}
draw_text(base_x, y_ac, txt_ac);

var txt_bk = "BACK TO MENU";
var w_bk = string_width(txt_bk);
var h_bk = string_height(txt_bk);
var y_bk = start_y + (spacing * 3);

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