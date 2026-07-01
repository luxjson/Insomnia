if (text_alpha < 1) {
    text_alpha += text_fade_speed;
    if (text_alpha > 1) text_alpha = 1;
}

for (var i = 0; i < array_length(shatter_particles); i++) {
    var p = shatter_particles[i];
    p.xx += p.vx;
    p.yy += p.vy;
    p.alpha -= 0.001;
    if (p.alpha <= 0) {
        p.alpha = random_range(0.1, 0.4);
        p.xx = random(display_get_gui_width());
        p.yy = -10;
        p.size = random_range(2, 6);
        p.vx = random_range(-0.3, 0.3);
        p.vy = random_range(0.2, 0.8);
    }
}

if (!save_menu_open && !is_transitioning) {
    if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_down)) {
        if (!shattered_try) {
            menu_index = (menu_index == 0) ? 1 : 0;
        } else {
            menu_index = 1;
        }
        audio_play_sound(Beep, 1, false);
    }
    
    if (keyboard_check_pressed(ord("Z"))) {
        audio_play_sound(Beep, 1, false);

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
                        for (var i = 0; i < 30; i++) {
                            array_push(shatter_particles, {
                                xx: gui_w / 2 + random_range(-80, 80),
                                yy: (gui_h / 2 + 60) + random_range(-10, 10),
                                vx: random_range(-5, 5),
                                vy: random_range(-7, -2),
                                alpha: 1.0,
                                size: random_range(3, 8),
                                color: c_red
                            });
                        }
                    }
                }
                break;
                
            case 1:
                is_transitioning = true;
                fade_alpha = 0;
                transition_timer = 0;
                break;
        }
    }
}

if (save_menu_open) {
    if (keyboard_check_pressed(vk_up)) { save_index--; if (save_index < 0) save_index = array_length(save_slots) - 1; }
    if (keyboard_check_pressed(vk_down)) { save_index++; if (save_index > array_length(save_slots) - 1) save_index = 0; }
    if (keyboard_check_pressed(ord("X"))) { save_menu_open = false; }
    
    if (keyboard_check_pressed(ord("Z"))) {
        if (file_exists("save.json")) {
            scr_load_game("save.json");
            save_menu_open = false;
        } else {
            save_menu_open = false;
            shattered_try = true;
            menu_index = 1;
        }
    }
}

if (shake_try > 0) shake_try = max(0, shake_try - 2);

if (is_transitioning) {
    fade_alpha += 0.03;
    if (fade_alpha >= 1) {
        transition_timer++;
        if (transition_timer >= 10) {
            room_goto(rm_AbbyBedroom);
        }
    }
}