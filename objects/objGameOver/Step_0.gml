if (text_alpha < 1) {
    text_alpha += text_fade_speed;
    if (text_alpha > 1) text_alpha = 1;
}

if (!save_menu_open && !is_transitioning) {
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_down)) {
        if (!shattered_try) {
            menu_index = (menu_index == 0) ? 1 : 0;
        } else {
            menu_index = 1;
        }
    }
    
    if (keyboard_check_pressed(ord("Z"))) {
        var sfx = audio_play_sound(snd_beep, 1, false);
        if (variable_global_exists("vol_sfx")) audio_sound_gain(sfx, global.vol_sfx, 0);

        switch (menu_index) {
            case 0:
                if (!shattered_try) {
                    if (has_any_save) {
                        save_menu_open = true;
                        save_index = 0;
                    } else {
                        shattered_try = true;
                        menu_index = 1;
                        shake_try = 40;
                        
                        var gui_w = display_get_gui_width();
                        var gui_h = display_get_gui_height();
                        repeat(30) {
                            array_push(shatter_particles, {
                                xx: gui_w / 2 + random_range(-80, 80),
                                yy: (gui_h / 2 + 60) + random_range(-10, 10),
                                vx: random_range(-5, 5),
                                vy: random_range(-7, -2),
                                alpha: 1.0
                            });
                        }
                    }
                }
                break;
                
            case 1:
                is_transitioning = true;
                slice_max_width = display_get_gui_width() + 100;
                break;
        }
    }
}

if (save_menu_open) {
    if (keyboard_check_pressed(vk_up)) { save_index--; if (save_index < 0) save_index = array_length(save_slots) - 1; }
    if (keyboard_check_pressed(vk_down)) { save_index++; if (save_index > array_length(save_slots) - 1) save_index = 0; }
    if (keyboard_check_pressed(ord("X"))) save_menu_open = false;
    
    if (keyboard_check_pressed(ord("Z"))) {
        var file_name = "save_" + string(save_index) + ".dat";
        if (file_exists(file_name)) {
            try {
                game_load(file_name);
                save_menu_open = false;
            } catch(_exception) {
                save_menu_open = false;
                shattered_try = true;
                menu_index = 1;
            }
        }
    }
}

if (shake_try > 0) shake_try = max(0, shake_try - 2);

for (var i = array_length(shatter_particles) - 1; i >= 0; i--) {
    var p = shatter_particles[i];
    p.xx += p.vx; p.yy += p.vy; p.vy += 0.2; p.alpha -= 0.02;
    if (p.alpha <= 0) array_delete(shatter_particles, i, 1);
}

if (is_transitioning) {
    var all_slices_full = true;
    for (var i = 0; i < slice_count; i++) {
        if (slice_widths[i] < slice_max_width) { slice_widths[i] += slice_speeds[i]; all_slices_full = false; }
    }
    if (all_slices_full) {
        transition_timer++;
        if (transition_timer == 1) room_goto(rm_gameplay);
        if (transition_timer >= 30) instance_destroy();
    }
}

