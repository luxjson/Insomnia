if (config_cooldown > 0) config_cooldown--;

var key_z = keyboard_check_pressed(controls[2][1]);
var key_x = keyboard_check_pressed(controls[3][1]);
var key_menu = keyboard_check_pressed(ord("C")) || keyboard_check_pressed(vk_escape);
var play_beep = false;

if (key_menu && !shattered_continue && !config_open && !is_transitioning && show_menu_buttons) {
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
        if (key_x && !config_open) {
        }
        if (keyboard_check_pressed(vk_up)) { menu_index--; if (menu_index < 0) menu_index = 2; play_beep = true; }
        if (keyboard_check_pressed(vk_down)) { menu_index++; if (menu_index > 2) menu_index = 0; play_beep = true; }
        if (key_z) {
            switch (menu_index) {
                case 0:
                    is_transitioning = true;
                    slice_max_width = display_get_gui_width() + 100;
                    play_beep = true;
                    break;
                case 1:
                    if (file_exists("save.json")) {
                        scr_load_game("save.json");
                        play_beep = true;
                    } else {
                        shake_continue = 30;
                        error_flash_continue = 45;
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

    if (key_x && !is_rebinding) {
        config_target_y = -400;
        play_beep = true;
    }

    if (config_open && config_target_y == 0 && config_cooldown == 0) {
        if (!is_rebinding) {
            if (keyboard_check_pressed(vk_left)) { config_tab--; if (config_tab < 0) config_tab = 2; config_idx = 0; play_beep = true; }
            if (keyboard_check_pressed(vk_right)) { config_tab++; if (config_tab > 2) config_tab = 0; config_idx = 0; play_beep = true; }

            var max_idx;
            switch (config_tab) {
                case 0: max_idx = 2; break;
                case 1: max_idx = 2; break;
                case 2: max_idx = 3; break;
            }

            if (keyboard_check_pressed(vk_up)) { config_idx--; if (config_idx < 0) config_idx = max_idx; play_beep = true; }
            if (keyboard_check_pressed(vk_down)) { config_idx++; if (config_idx > max_idx) config_idx = 0; play_beep = true; }

            if (config_tab == 0) {
                if (config_idx == 0 && key_z) {
                    resolution_index = (resolution_index + 1) % array_length(resolutions);
                    var res = resolutions[resolution_index];
                    window_set_size(res[0], res[1]);
                    display_set_gui_size(res[0], res[1]);
                    ini_open("configuracoes.ini");
                    ini_write_real("Video", "ResolutionIndex", resolution_index);
                    ini_close();
                    play_beep = true;
                }
                if (config_idx == 1) {
                    if (keyboard_check(vk_right)) { global.contrast_value = min(2.0, global.contrast_value + 0.1); play_beep = true; }
                    if (keyboard_check(vk_left)) { global.contrast_value = max(0.5, global.contrast_value - 0.1); play_beep = true; }
                    if (keyboard_check(vk_right) || keyboard_check(vk_left)) {
                        ini_open("configuracoes.ini");
                        ini_write_real("Video", "Contrast", global.contrast_value);
                        ini_close();
                    }
                }
                if (config_idx == 2) {
                    if (keyboard_check(vk_right)) { text_scale = min(2.0, text_scale + 0.1); play_beep = true; }
                    if (keyboard_check(vk_left)) { text_scale = max(0.5, text_scale - 0.1); play_beep = true; }
                    if (keyboard_check(vk_right) || keyboard_check(vk_left)) {
                        ini_open("configuracoes.ini");
                        ini_write_real("Interface", "TextScale", text_scale);
                        ini_close();
                    }
                }
            }

            if (config_tab == 1) {
                if (key_z) {
                    switch (config_idx) {
                        case 0: scr_save_game(); play_beep = true; break;
                        case 1: if (file_exists("save.json")) { scr_load_game("save.json"); play_beep = true; } else { shake_continue = 30; error_flash_continue = 45; play_beep = true; } break;
                        case 2: game_end(); break;
                    }
                }
            }

            if (config_tab == 2) {
                if (key_z) {
                    is_rebinding = true;
                    keyboard_lastkey = -1;
                    play_beep = true;
                }
            }
        } else {
            var key = keyboard_lastkey;
            if (key != -1) {
                if (key != ord("X") && key != ord("Z")) {
                    controls[config_idx][1] = key;
                    ini_open("configuracoes.ini");
                    switch (config_idx) {
                        case 0: ini_write_real("Controls", "Left", key); break;
                        case 1: ini_write_real("Controls", "Right", key); break;
                        case 2: ini_write_real("Controls", "Z", key); break;
                        case 3: ini_write_real("Controls", "X", key); break;
                    }
                    ini_close();
                    play_beep = true;
                }
                is_rebinding = false;
            }
        }
    }
}

if (shake_continue > 0) shake_continue = max(0, shake_continue - 2);
if (shake_load > 0) shake_load = max(0, shake_load - 2);
if (error_flash_continue > 0) error_flash_continue--;
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
        if (transition_timer == 1) room_goto(rm_gameplay);
        if (transition_timer >= 30) instance_destroy();
    }
}

if (play_beep) {
    var sfx = audio_play_sound(snd_beep, 1, false);
    audio_sound_gain(sfx, global.vol_sfx, 0);
}