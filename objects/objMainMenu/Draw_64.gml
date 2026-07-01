gpu_set_texfilter(false);
draw_sprite_ext(current_bg, 0, 0, 0, 1, 1, 0, c_white, menu_alpha);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var base_x = gui_w / 2;

if (current_state == MENU_STATE.MAIN) {
    draw_set_font(global.fonteNormal);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    var total_options = array_length(main_options);
    var start_y = gui_h - 100 - ((total_options - 1) * spacing);
    for (var i = 0; i < total_options; i++) {
        var txt = main_options[i];
        var y_pos = start_y + (i * spacing);
        if (selected_option == i) {
            draw_set_color(c_aqua);
            txt = "> " + txt + " <";
        } else {
            draw_set_color(c_white);
        }
        draw_set_alpha(menu_alpha);
        draw_text(base_x, y_pos, txt);
    }
    draw_set_font(global.fonteLegenda);
    draw_set_color(c_gray);
    draw_set_alpha(menu_alpha);
    draw_text(base_x, gui_h - 20, "V0.11b");
} else if (current_state == MENU_STATE.SETTINGS) {
    var total_options = array_length(settings_options);
    var start_y = gui_h - 110 - ((total_options - 2) * spacing);
    for (var i = 0; i < total_options; i++) {
        var txt = settings_options[i];
        if (i != total_options - 1) {
            switch (i) {
                case 0: txt += (global.fullscreen ? "ON" : "OFF"); break;
                case 1: txt += string(round(global.vol_bgm * 100)) + "%"; break;
                case 2: txt += string(round(global.vol_sfx * 100)) + "%"; break;
                case 3: txt += (global.achievements ? "ENABLED" : "DISABLED"); break;
            }
            var y_pos = start_y + (i * spacing);
            draw_set_font(global.fonteNormal);
            draw_set_valign(fa_middle);
        } else {
            var y_pos = gui_h - 20;
            draw_set_font(global.fonteLegenda);
            draw_set_valign(fa_bottom);
        }
        if (selected_option == i) {
            draw_set_color(c_aqua);
            txt = "> " + txt + " <";
        } else {
            if (i == total_options - 1) draw_set_color(c_gray);
            else draw_set_color(c_white);
        }
        draw_set_halign(fa_center);
        draw_set_alpha(menu_alpha);
        draw_text(base_x, y_pos, txt);
    }
} else if (current_state == MENU_STATE.CREDITS) {
    draw_set_font(global.fonteNormal);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    var total_lines = array_length(credits_text);
    var start_y = gui_h - 70 - ((total_lines - 2) * spacing);
    for (var i = 0; i < total_lines; i++) {
        var txt = credits_text[i];
        if (i != total_lines - 1) {
            var y_pos = start_y + (i * spacing);
            draw_set_font(global.fonteNormal);
            draw_set_valign(fa_middle);
        } else {
            var y_pos = gui_h - 20;
            draw_set_font(global.fonteLegenda);
            draw_set_valign(fa_bottom);
        }
        if (i == total_lines - 1) {
            if (selected_option == i) {
                draw_set_color(c_aqua);
                txt = "> " + txt + " <";
            } else {
                draw_set_color(c_gray);
            }
        } else {
            draw_set_color(c_white);
        }
        draw_set_alpha(menu_alpha);
        draw_text(base_x, y_pos, txt);
    }
}

draw_set_alpha(1.0);
draw_set_color(c_white);
gpu_set_texfilter(false);