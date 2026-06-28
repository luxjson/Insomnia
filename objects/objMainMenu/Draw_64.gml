gpu_set_texfilter(false);

draw_sprite_ext(current_bg, 0, 0, 0, 1, 1, 0, c_white, menu_alpha);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

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
        
        var w = string_width(txt);
        var h = string_height(txt);
        var x1 = base_x - (w / 2);
        var x2 = base_x + (w / 2);
        var y1 = y_pos - (h / 2);
        var y2 = y_pos + (h / 2);
        
        if (!is_fading && mx >= x1 && mx <= x2 && my >= y1 && my <= y2) {
            draw_set_color(c_aqua);
            if (mouse_check_button_pressed(mb_left)) {
                audio_play_sound(snd_beep, 1, false);
                switch (i) {
                    case 0:
                        fade_target_room = rm_game;
                        is_fading = true;
                        break;
                    case 1:
                        fade_target_state = MENU_STATE.SETTINGS;
                        is_fading = true;
                        break;
                    case 2:
                        fade_target_state = MENU_STATE.CREDITS;
                        fade_target_bg = sprCredits;
                        is_fading = true;
                        break;
                    case 3:
                        game_end();
                        break;
                }
            }
        } else {
            draw_set_color(c_white);
        }
        
        draw_set_alpha(menu_alpha);
        draw_text(base_x, y_pos, txt);
    }
    
    draw_set_font(global.fonteLegenda);
    draw_set_color(c_gray);
    draw_set_alpha(menu_alpha);
    draw_text(base_x, gui_h - 20, "V0.03b");
}

else if (current_state == MENU_STATE.SETTINGS) {
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
        
        var w = string_width(txt);
        var h = string_height(txt);
        var x1 = base_x - (w / 2);
        var x2 = base_x + (w / 2);
        var y1 = (i != total_options - 1) ? (y_pos - (h / 2)) : (y_pos - h);
        var y2 = y_pos;
        
        if (!is_fading && mx >= x1 && mx <= x2 && my >= y1 && my <= y2) {
            draw_set_color(c_aqua);
            if (mouse_check_button_pressed(mb_left)) {
                audio_play_sound(snd_beep, 1, false);
                switch (i) {
                    case 0:
                        global.fullscreen = !global.fullscreen;
                        window_set_fullscreen(global.fullscreen);
                        ini_open("configuracoes.ini");
                        ini_write_real("Video", "Fullscreen", global.fullscreen);
                        ini_close();
                        alarm[11] = 2;
                        break;
                    case 1:
                        global.vol_bgm += 0.1;
                        if (global.vol_bgm > 1.05) global.vol_bgm = 0;
                        ini_open("configuracoes.ini");
                        ini_write_real("Audio", "Volume_BGM", global.vol_bgm);
                        ini_close();
                        break;
                    case 2:
                        global.vol_sfx += 0.1;
                        if (global.vol_sfx > 1.05) global.vol_sfx = 0;
                        audio_sound_gain(snd_beep, global.vol_sfx, 0);
                        ini_open("configuracoes.ini");
                        ini_write_real("Audio", "Volume_SFX", global.vol_sfx);
                        ini_close();
                        break;
                    case 3:
                        global.achievements = !global.achievements;
                        ini_open("configuracoes.ini");
                        ini_write_real("Gameplay", "Achievements", global.achievements);
                        ini_close();
                        break;
                    case 4:
                        fade_target_state = MENU_STATE.MAIN;
                        is_fading = true;
                        break;
                }
            }
        } else {
            if (i == total_options - 1) draw_set_color(c_gray);
            else draw_set_color(c_white);
        }
        
        draw_set_halign(fa_center);
        draw_set_alpha(menu_alpha);
        draw_text(base_x, y_pos, txt);
    }
}

else if (current_state == MENU_STATE.CREDITS) {
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
        
        var w = string_width(txt);
        var h = string_height(txt);
        var x1 = base_x - (w / 2);
        var x2 = base_x + (w / 2);
        var y1 = (i != total_lines - 1) ? (y_pos - (h / 2)) : (y_pos - h);
        var y2 = y_pos;
        
        if (i == total_lines - 1) {
            if (!is_fading && mx >= x1 && mx <= x2 && my >= y1 && my <= y2) {
                draw_set_color(c_aqua);
                if (mouse_check_button_pressed(mb_left)) {
                    audio_play_sound(snd_beep, 1, false);
                    fade_target_state = MENU_STATE.MAIN;
                    fade_target_bg = sprMenu;
                    is_fading = true;
                }
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

if (!is_fading && menu_alpha == 0) {
    is_fading = false;
}

draw_set_alpha(1.0);
draw_set_color(c_white);
gpu_set_texfilter(false);