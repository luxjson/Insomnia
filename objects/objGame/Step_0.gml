if (game_starting) exit;
if (config_cooldown > 0) config_cooldown--;

var key_z = keyboard_check_pressed(ord("Z"));
var key_x = keyboard_check_pressed(ord("X"));
var key_menu = keyboard_check_pressed(ord("C")) || keyboard_check_pressed(vk_escape);
var play_beep = false;

if (menu_sub_state == "submenu_load_info") {
    if (load_menu_cooldown > 0) {
        load_menu_cooldown--;
    }
    if (key_z && load_menu_cooldown == 0) {
        play_beep = true;
        if (file_exists("save.json")) {
            var _f = file_text_open_read("save.json");
            var _json = file_text_read_string(_f);
            file_text_close(_f);
            global.load_data = json_parse(_json);
            with (instance_create_depth(0, 0, -10000, objTransition)) {
                target_room = asset_get_index(global.load_data.room_name);
            }
        }
        menu_sub_state = "main";
    }
    if (key_x) {
        menu_sub_state = "main";
        play_beep = true;
        load_menu_cooldown = 0;
    }
    if (play_beep) {
        var sfx = audio_play_sound(Beep, 1, false);
        audio_sound_gain(sfx, global.vol_sfx, 0);
    }
    exit;
}

if (key_menu && !config_open && !is_transitioning && show_menu_buttons) {
    config_open = true;
    config_target_y = 0;
    config_idx = 0;
    config_tab = 0;
    config_cooldown = 5;
    play_beep = true;
}

if (!config_open && !save_menu_open && !is_transitioning) {
    if (!show_menu_buttons) {
        var is_question = (current_text_index >= 12 && current_text_index <= 24 && current_text_index % 2 == 0);
        if (!show_menu_buttons && current_text_index < array_length(history_texts)) {
            show_skip_prompt = true;
        } else {
            show_skip_prompt = false;
        }
        if (show_skip_prompt && keyboard_check_pressed(ord("X"))) {
            current_text_index = array_length(history_texts);
            show_menu_buttons = true;
            text_state = 0;
            text_alpha = 1;
            show_skip_prompt = false;
        }
        switch (text_state) {
            case 0:
                if (key_z && !is_question) { text_alpha = 1; text_state = 1; text_timer = 0; }
                else { text_alpha += text_fade_speed; if (text_alpha >= 1) { text_alpha = 1; text_state = 1; text_timer = 0; } }
                break;
            case 1:
                if (is_question) {
                    if (keyboard_check_pressed(vk_up)) { choice_index--; if (choice_index < 0) choice_index = 2; play_beep = true; }
                    if (keyboard_check_pressed(vk_down)) { choice_index++; if (choice_index > 2) choice_index = 0; play_beep = true; }
                    if (key_z) {
                        var q_idx = (current_text_index - 12) / 2;
                        global.history_answers[q_idx] = choice_index;
                        history_texts[current_text_index + 1] = game_replies[q_idx][choice_index];
                        choice_index = 0;
                        text_state = 2;
                        play_beep = true;
                    }
                } else {
                    text_timer++;
                    if (text_timer >= text_duration || key_z) {
                        if (current_text_index == 25) {
                            var negative_points = 0;
                            for (var i = 0; i < 7; i++) {
                                if (global.history_answers[i] == 0) negative_points++;
                            }
                            if (negative_points >= 5) history_texts[26] = "So... you are drowning in this very same quiet void too.";
                            else if (negative_points >= 2) history_texts[26] = "I see. You have tasted this numbness, even if just a little.";
                            else history_texts[26] = "I envy you. Your world still holds onto its colors.";
                        }
                        text_state = 2;
                    }
                }
                break;
            case 2:
                if (key_z && !is_question) {
                    text_alpha = 0;
                    current_text_index++;
                    if (current_text_index >= array_length(history_texts)) show_menu_buttons = true;
                    else text_state = 0;
                    play_beep = true;
                } else {
                    text_alpha -= text_fade_speed;
                    if (text_alpha <= 0) {
                        text_alpha = 0;
                        current_text_index++;
                        if (current_text_index >= array_length(history_texts)) show_menu_buttons = true;
                        else text_state = 0;
                    }
                }
                break;
        }
    } else {
        if (keyboard_check_pressed(vk_up)) {
            menu_index--;
            if (menu_index < 0) menu_index = array_length(main_options) - 1;
        }
        if (keyboard_check_pressed(vk_down)) {
            menu_index++;
            if (menu_index >= array_length(main_options)) menu_index = 0;
        }
        if (key_z) {
            switch (menu_index) {
                case 0:
                    if (!instance_exists(objIntroSequence)) {
                        game_starting = true;
                        with (instance_create_depth(0, 0, -10000, objIntroSequence)) {}
                    }
                    play_beep = true;
                    break;
                case 1:
                    if (has_any_save) {
                        menu_sub_state = "submenu_load_info";
                        load_menu_cooldown = 10;
                        play_beep = true;
                    } else {
                        shake_load = 30;
                        error_flash_load = 45;
                        play_beep = true;
                    }
                    break;
                case 2:
                    config_open = true;
                    config_target_y = 0;
                    config_idx = 0;
                    config_tab = 0;
                    config_cooldown = 5;
                    play_beep = true;
                    break;
            }
        }
    }
}

if (config_open) {
    config_y += (config_target_y - config_y) * config_anim_speed;
    if (config_target_y == -400 && abs(config_y - config_target_y) < 5) config_open = false;
    if (key_x) {
        config_target_y = -400;
        play_beep = true;
    }
    if (config_open && config_target_y == 0 && config_cooldown == 0) {
        if (keyboard_check_pressed(vk_left)) { config_tab--; if (config_tab < 0) config_tab = 3; config_idx = 0; play_beep = true; }
        if (keyboard_check_pressed(vk_right)) { config_tab++; if (config_tab > 3) config_tab = 0; config_idx = 0; play_beep = true; }
        var max_idx;
        switch (config_tab) {
            case 0: max_idx = 0; break;
            case 1: max_idx = 1; break;
            case 2: max_idx = array_length(controls) - 1; break;
            case 3: max_idx = 0; break;
        }
        if (keyboard_check_pressed(vk_up)) { config_idx--; if (config_idx < 0) config_idx = max_idx; play_beep = true; }
        if (keyboard_check_pressed(vk_down)) { config_idx++; if (config_idx > max_idx) config_idx = 0; play_beep = true; }
        if (config_tab == 0) {
            if (config_idx == 0 && key_z) {
                global.fullscreen = !global.fullscreen;
                window_set_fullscreen(global.fullscreen);
                ini_open("configuracoes.ini");
                ini_write_real("Video", "Fullscreen", global.fullscreen);
                ini_close();
                play_beep = true;
            }
        }
        if (config_tab == 1) {
            if (key_z) {
                if (config_idx == 0) {
                    global.vol_bgm += 0.1;
                    if (global.vol_bgm > 1.05) global.vol_bgm = 0;
                    if (variable_global_exists("music_id")) {
                        audio_sound_gain(global.music_id, global.vol_bgm, 0);
                    }
                    ini_open("configuracoes.ini");
                    ini_write_real("Audio", "Volume_BGM", global.vol_bgm);
                    ini_close();
                    play_beep = true;
                }
                if (config_idx == 1) {
                    global.vol_sfx += 0.1;
                    if (global.vol_sfx > 1.05) global.vol_sfx = 0;
                    ini_open("configuracoes.ini");
                    ini_write_real("Audio", "Volume_SFX", global.vol_sfx);
                    ini_close();
                    play_beep = true;
                }
            }
        }
        if (config_tab == 2) {
        }
        if (config_tab == 3) {
            if (config_idx == 0 && key_z) {
                url_open("https://somiari.itch.io/insomnia");
                play_beep = true;
            }
        }
    }
}

if (shake_load > 0) shake_load = max(0, shake_load - 2);
if (error_flash_load > 0) error_flash_load--;
for (var i = array_length(shatter_particles) - 1; i >= 0; i--) {
    var p = shatter_particles[i];
    p.xx += p.vx;
    p.yy += p.vy;
    p.vy += 0.2;
    p.alpha -= 0.02;
    if (p.alpha <= 0) array_delete(shatter_particles, i, 1);
}
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
for (var i = 0; i < max_pixels; i++) {
    pixel_list[i].yy += pixel_list[i].spd;
    if (pixel_list[i].yy > gui_h) {
        pixel_list[i].yy = -10;
        pixel_list[i].xx = random(gui_w);
        pixel_list[i].spd = random_range(0.5, 1.5);
    }
}
if (is_transitioning) {
    var all_slices_full = true;
    for (var i = 0; i < slice_count; i++) {
        if (slice_widths[i] < slice_max_width) {
            slice_widths[i] += slice_speeds[i];
            all_slices_full = false;
        }
    }
    if (all_slices_full) {
        transition_timer++;
        if (transition_timer == 1) room_goto(rm_AbbyBedroom);
        if (transition_timer >= 30) instance_destroy();
    }
}
if (play_beep) {
    var sfx = audio_play_sound(Beep, 1, false);
    audio_sound_gain(sfx, global.vol_sfx, 0);
}