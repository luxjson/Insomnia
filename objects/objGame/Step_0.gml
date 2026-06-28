if (config_cooldown > 0) config_cooldown--;

if (!config_open && !save_menu_open && !is_transitioning) {
    if (!show_menu_buttons) {
        
        // Mapeamento dos índices exatos de perguntas no novo array de 29 posições
        var is_question = (current_text_index == 12 || current_text_index == 14 || current_text_index == 16 || current_text_index == 18 || current_text_index == 20 || current_text_index == 22 || current_text_index == 24);
        
        switch (text_state) {
            case 0: // Fade In
                if (keyboard_check_pressed(ord("Z")) && !is_question) {
                    text_alpha = 1; text_state = 1; text_timer = 0;
                } else {
                    text_alpha += text_fade_speed;
                    if (text_alpha >= 1) { text_alpha = 1; text_state = 1; text_timer = 0; }
                }
                break;
                
            case 1: // Texto visível
                if (is_question) {
                    if (keyboard_check_pressed(vk_up)) { choice_index--; if (choice_index < 0) choice_index = 2; }
                    if (keyboard_check_pressed(vk_down)) { choice_index++; if (choice_index > 2) choice_index = 0; }
                    
                    if (keyboard_check_pressed(ord("Z"))) {
                        // Calcula qual o número da pergunta (0 a 6)
                        var q_idx = (current_text_index - 12) / 2;
                        global.history_answers[q_idx] = choice_index;
                        
                        // INSERÇÃO FLUIDA: Copia a resposta para a string vazia do próximo slide!
                        history_texts[current_text_index + 1] = game_replies[q_idx][choice_index];
                        
                        choice_index = 0; 
                        text_state = 2; // Passa para o fade out natural para exibir a resposta a seguir
                    }
                } else {
                    text_timer++;
                    if (text_timer >= text_duration || keyboard_check_pressed(ord("Z"))) {
                        
                        // ANÁLISE DE PERFIL: Roda exatamente após a última resposta do jogo (slide 25) ser lida
                        if (current_text_index == 25) {
                            var negative_points = 0;
                            for(var i = 0; i < 7; i++) { if (global.history_answers[i] == 0) negative_points++; }
                            
                            if (negative_points >= 5) history_texts[26] = "So... you are drowning in this very same quiet void too.";
                            else if (negative_points >= 2) history_texts[26] = "I see. You have tasted this numbness, even if just a little.";
                            else history_texts[26] = "I envy you. Your world still holds onto its colors.";
                        }
                        text_state = 2;
                    }
                }
                break;
                
            case 2: // Fade Out
                if (keyboard_check_pressed(ord("Z")) && !is_question) {
                    text_alpha = 0; current_text_index++;
                    if (current_text_index >= array_length(history_texts)) show_menu_buttons = true;
                    else text_state = 0;
                } else {
                    text_alpha -= text_fade_speed;
                    if (text_alpha <= 0) {
                        text_alpha = 0; current_text_index++;
                        if (current_text_index >= array_length(history_texts)) show_menu_buttons = true;
                        else text_state = 0;
                    }
                }
                break;
        }
    } else {
        if (keyboard_check_pressed(vk_up)) {
            var original_index = menu_index;
            menu_index--; if (menu_index < 0) menu_index = 3;
            while ((menu_index == 1 && shattered_continue) || (menu_index == 2 && shattered_load)) {
                menu_index--; if (menu_index < 0) menu_index = 3;
                if (menu_index == original_index) break;
            }
        }
        if (keyboard_check_pressed(vk_down)) {
            var original_index = menu_index;
            menu_index++; if (menu_index > 3) menu_index = 0;
            while ((menu_index == 1 && shattered_continue) || (menu_index == 2 && shattered_load)) {
                menu_index++; if (menu_index > 3) menu_index = 0;
                if (menu_index == original_index) break;
            }
        }

        if (keyboard_check_pressed(ord("Z"))) {
            switch (menu_index) {
                case 0: 
                    is_transitioning = true;
                    slice_max_width = display_get_gui_width() + 100;
                    break;
                    
                case 1: 
                    if (!shattered_continue) {
                        if (has_any_save) { 
                            try {
                                if (file_exists("save.dat")) game_load("save.dat");
                                else if (file_exists("save_0.dat")) game_load("save_0.dat");
                                is_transitioning = true;
                                slice_max_width = display_get_gui_width() + 100;
                            } catch(_exception) {
                                click_count_continue = 2; 
                            }
                        }
                        
                        if (!has_any_save || click_count_continue >= 2) {
                            click_count_continue++;
                            if (click_count_continue == 1) {
                                shake_continue = 30; 
                                error_flash_continue = 45; 
                            } else if (click_count_continue >= 2) {
                                shattered_continue = true;
                                menu_index = 0; 
                                var gui_w = display_get_gui_width();
                                var gui_h = display_get_gui_height();
                                repeat(25) {
                                    array_push(shatter_particles, {
                                        xx: gui_w / 2 + random_range(-100, 100),
                                        yy: (gui_h / 2 - 20) + 40 + random_range(-10, 10),
                                        vx: random_range(-4, 4),
                                        vy: random_range(-6, -1),
                                        alpha: 1.0
                                    });
                                }
                            }
                        }
                    }
                    break;
                    
                case 2: 
                    if (!shattered_load) {
                        if (has_any_save) {
                            save_menu_open = true;
                            save_index = 0;
                        } else {
                            click_count_load++;
                            if (click_count_load == 1) {
                                shake_load = 30;
                                error_flash_load = 45;
                            } else if (click_count_load >= 2) {
                                shattered_load = true;
                                menu_index = 0; 
                                var gui_w = display_get_gui_width();
                                var gui_h = display_get_gui_height();
                                repeat(25) {
                                    array_push(shatter_particles, {
                                        xx: gui_w / 2 + random_range(-100, 100),
                                        yy: (gui_h / 2 - 20) + 80 + random_range(-10, 10),
                                        vx: random_range(-4, 4),
                                        vy: random_range(-6, -1),
                                        alpha: 1.0
                                    });
                                }
                            }
                        }
                    }
                    break;
                    
                case 3: 
                    config_open = true;
                    config_target_y = 0; config_idx = 0; config_tab = 0; config_cooldown = 5;
                    break;
            }
        }
    }
}

if (shake_continue > 0) shake_continue = max(0, shake_continue - 2);
if (shake_load > 0)      shake_load = max(0, shake_load - 2);
if (error_flash_continue > 0) error_flash_continue--;
if (error_flash_load > 0)      error_flash_load--;

for (var i = array_length(shatter_particles) - 1; i >= 0; i--) {
    var p = shatter_particles[i];
    p.xx += p.vx; p.yy += p.vy; p.vy += 0.2; p.alpha -= 0.02;
    if (p.alpha <= 0) array_delete(shatter_particles, i, 1);
}

if (save_menu_open) {
    if (keyboard_check_pressed(vk_up)) { save_index--; if (save_index < 0) save_index = array_length(save_slots) - 1; }
    if (keyboard_check_pressed(vk_down)) { save_index++; if (save_index > array_length(save_slots) - 1) save_index = 0; }
    if (keyboard_check_pressed(ord("X"))) save_menu_open = false;
    if (keyboard_check_pressed(ord("Z"))) {
        var file_name = "save_" + string(save_index) + ".dat";
        if (file_exists(file_name)) { 
            try { game_load(file_name); save_menu_open = false; } 
            catch(_exception) { save_menu_open = false; shattered_load = true; menu_index = 0; }
        }
    }
}

if (config_open) {
    config_y += (config_target_y - config_y) * config_anim_speed;
    if (keyboard_check_pressed(ord("X")) && !is_rebinding) config_target_y = -400;
    if (config_target_y == -400 && abs(config_y - config_target_y) < 5) config_open = false;
    
    if (config_open && config_target_y == 0 && !is_rebinding && config_cooldown == 0) {
        if (keyboard_check_pressed(vk_left)) { config_tab--; if (config_tab < 0) config_tab = 2; config_idx = 0; }
        if (keyboard_check_pressed(vk_right)) { config_tab++; if (config_tab > 2) config_tab = 0; config_idx = 0; }
        var max_idx = (config_tab == 0) ? 2 : ((config_tab == 1) ? 2 : 3);
        if (keyboard_check_pressed(vk_up)) { config_idx--; if (config_idx < 0) config_idx = max_idx; }
        if (keyboard_check_pressed(vk_down)) { config_idx++; if (config_idx > max_idx) config_idx = 0; }
        
        if (config_tab == 0) {
            if (config_idx == 0 && keyboard_check_pressed(ord("Z"))) {
                resolution_index = (resolution_index + 1) % array_length(resolutions);
                var res = resolutions[resolution_index];
                window_set_size(res[0], res[1]); display_set_gui_size(res[0], res[1]);
                ini_open("configuracoes.ini"); ini_write_real("Video", "ResolutionIndex", resolution_index); ini_close();
            }
            if (config_idx == 1) {
                var changed = false;
                if (keyboard_check_pressed(vk_right)) { global.contrast_value = min(2.0, global.contrast_value + 0.1); changed = true; }
                if (keyboard_check_pressed(vk_left))  { global.contrast_value = max(0.5, global.contrast_value - 0.1); changed = true; }
                if (changed) { ini_open("configuracoes.ini"); ini_write_real("Video", "Contrast", global.contrast_value); ini_close(); }
            }
            if (config_idx == 2) {
                var changed = false;
                if (keyboard_check_pressed(vk_right)) { text_scale = min(2.0, text_scale + 0.1); changed = true; }
                if (keyboard_check_pressed(vk_left))  { text_scale = max(0.5, text_scale - 0.1); changed = true; }
                if (changed) { ini_open("configuracoes.ini"); ini_write_real("Interface", "TextScale", text_scale); ini_close(); }
            }
        }
        if (config_tab == 1 && keyboard_check_pressed(ord("Z"))) {
            switch (config_idx) {
                case 0: game_save("save.dat"); break;
                case 1: game_load("save.dat"); break;
                case 2: game_end(); break;
            }
        }
        if (config_tab == 2 && keyboard_check_pressed(ord("Z"))) { is_rebinding = true; keyboard_lastkey = -1; }
    } else if (is_rebinding) {
        if (keyboard_lastkey != -1) {
            if (keyboard_lastkey != ord("X") && keyboard_lastkey != ord("Z")) {
                controls[config_idx][1] = keyboard_lastkey;
                ini_open("configuracoes.ini");
                switch(config_idx) {
                    case 0: ini_write_real("Controls", "Left",  keyboard_lastkey); break;
                    case 1: ini_write_real("Controls", "Right", keyboard_lastkey); break;
                    case 2: ini_write_real("Controls", "Z",     keyboard_lastkey); break;
                    case 3: ini_write_real("Controls", "X",     keyboard_lastkey); break;
                }
                ini_close();
            }
            is_rebinding = false;
        }
    }
}

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
for (var i = 0; i < max_pixels; i++) {
    pixel_list[i].yy += pixel_list[i].spd;
    if (pixel_list[i].yy > gui_h) {
        pixel_list[i].yy = -10; pixel_list[i].xx = random(gui_w); pixel_list[i].spd = random_range(0.5, 1.5);
    }
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