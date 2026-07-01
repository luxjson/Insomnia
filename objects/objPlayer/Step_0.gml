if (instance_exists(objDialogue)) {
    hspd = 0;
    vspd = 0;
    state = "idle"; 
    exit; 
}

if (instance_exists(objSleepTrigger)) {
	if (objSleepTrigger.sleeping) {
	    hspd = 0;
	    vspd = 0;
	    state = "idle"; 
	    exit; 
	}
}

if (instance_exists(objCh0101)) {
	if (!objCh0101.started_story) {
	    hspd = 0;
	    vspd = 0;
	    state = "idle"; 
	    exit; 
	}
}

if (global.puzzle_active) {
    hspd = 0;
    vspd = 0;
    state = "idle";
    exit;
}


if (config_cooldown > 0) config_cooldown--;

var move_left  = keyboard_check(controls[0][1]);
var move_right = keyboard_check(controls[1][1]);
var move_up    = keyboard_check(vk_up);
var move_down  = keyboard_check(vk_down);
var key_shift  = keyboard_check_pressed(vk_shift);
var key_z      = keyboard_check_pressed(controls[2][1]);
var key_x      = keyboard_check_pressed(controls[3][1]);
var key_menu   = keyboard_check_pressed(ord("C")) || keyboard_check_pressed(vk_escape);

var play_beep = false;

if (key_menu && !shattered_continue && (menu_sub_state == "main" || menu_sub_state == "submenu_options" || menu_sub_state == "submenu_game" || menu_sub_state == "submenu_controls" || menu_sub_state == "submenu_save_confirm" || menu_sub_state == "submenu_load_info")) {
    config_open = !config_open;
    config_target_y = config_open ? 0 : -400;
    if (config_open) { config_idx = 0; config_tab = 0; config_cooldown = 5; menu_sub_state = "main"; }
    play_beep = true;
}

config_y += (config_target_y - config_y) * config_anim_speed;
if (config_target_y == -400 && abs(config_y - config_target_y) < 5) config_open = false;

if (!is_dead && hp_actual <= 0) {
    is_dead = true;
    state = "death";
    hspd = 0;
    vspd = 0;
    death_timer = 0;
}

if (is_dead) {
    death_timer++;
    if (death_timer >= 60) {
        room_goto(rm_GameOver);
    }
}

if (!config_open && config_target_y == -400) {
    if (state != "death") {
        var _h_input = move_right - move_left;
        var _v_input = move_down - move_up;
        var _len = sqrt(_h_input * _h_input + _v_input * _v_input);
        
        if (key_shift && !is_dashing && _len > 0) {
            is_dashing = true;
            dash_timer = dash_dur;
            if (!audio_is_playing(Dash)) {
                var som_Dash = audio_play_sound(Dash, 10, false);
                audio_sound_gain(som_Dash, global.vol_sfx, 0);
            }

            dash_dir = dir;
            state = "dash";
            hspd = (_h_input / _len) * dash_spd;
            vspd = (_v_input / _len) * dash_spd;
            anim_speed = anim_speed_dash;
        }
        
        if (is_dashing) {
            dash_timer--;
            dir = dash_dir;
            state = "dash";
            if (dash_timer <= 0) {
                is_dashing = false;
                anim_speed = 0.15;
                if (hspd != 0 || vspd != 0) state = "walk"; else state = "idle";
            }
        } else {
            if (_len > 0) {
                hspd = (_h_input / _len) * spd;
                vspd = (_v_input / _len) * spd;
            } else {
                hspd = 0;
                vspd = 0;
            }
            if (vspd > 0) dir = 0;
            else if (hspd < 0) dir = 1;
            else if (vspd < 0) dir = 3;
            else if (hspd > 0) dir = 5;
            if (hspd != 0 || vspd != 0) {
                    state = "walk";
                    if (!audio_is_playing(Walk)) {
                        var som_Walk = audio_play_sound(Walk, 10, false);
                        audio_sound_gain(som_Walk, global.vol_sfx*10, 0);
                    }
                } else {
                    state = "idle";
                    if (audio_is_playing(Walk)) {
                        audio_stop_sound(Walk)
                    }
                }
        }
        
        if (place_meeting(x + hspd, y, obj)) {
            while (!place_meeting(x + sign(hspd), y, obj)) {
                x += sign(hspd);
            }
            hspd = 0;
        }
        x += hspd;
        
        if (place_meeting(x, y + vspd, obj)) {
            while (!place_meeting(x, y + sign(vspd), obj)) {
                y += sign(vspd);
            }
            vspd = 0;
        }
        y += vspd;
    }
    
    var half_w = sprite_width / 2;
    var half_h = sprite_height / 2;
    x = clamp(x, half_w, room_width - half_w);
    y = clamp(y, half_h, room_height - half_h);
    anim_frame += anim_speed;
} else if (config_open && config_target_y == 0 && config_cooldown == 0) {
    if (menu_sub_state == "main") {
        if (keyboard_check_pressed(vk_left))  { config_tab--; if (config_tab < 0) config_tab = 2; config_idx = 0; play_beep = true; }
        if (keyboard_check_pressed(vk_right)) { config_tab++; if (config_tab > 2) config_tab = 0; config_idx = 0; play_beep = true; }
        var max_idx = (config_tab == 0) ? 0 : ((config_tab == 1) ? max(0, array_length(inventory) - 1) : 3);
        if (keyboard_check_pressed(vk_up))    { config_idx--; if (config_idx < 0) config_idx = max_idx; play_beep = true; }
        if (keyboard_check_pressed(vk_down))  { config_idx++; if (config_idx > max_idx) config_idx = 0; play_beep = true; }
        if (key_z) {
            play_beep = true;
            if (config_tab == 1 && array_length(inventory) > 0) {
                menu_sub_state = "item_box";
                box_selected_opt = 0;
            } else if (config_tab == 2) {
                if (config_idx == 0) { menu_sub_state = "submenu_options"; sub_menu_idx = 0; }
                if (config_idx == 1) { menu_sub_state = "submenu_controls"; sub_menu_idx = 0; }
                if (config_idx == 2) { menu_sub_state = "submenu_game"; sub_menu_idx = 0; }
                if (config_idx == 3) game_end();
            }
        }
    } else if (menu_sub_state == "submenu_options") {
        if (keyboard_check_pressed(vk_up))   { sub_menu_idx--; if (sub_menu_idx < 0) sub_menu_idx = 3; play_beep = true; }
        if (keyboard_check_pressed(vk_down)) { sub_menu_idx++; if (sub_menu_idx > 3) sub_menu_idx = 0; play_beep = true; }
        if (sub_menu_idx == 0 && key_z) {
            play_beep = true;
            global.fullscreen = !global.fullscreen; window_set_fullscreen(global.fullscreen);
            ini_open("configuracoes.ini"); 
            ini_write_real("Video", "Fullscreen", global.fullscreen);
            ini_close();
        }
        if (sub_menu_idx == 1 && key_z) {
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
        if (sub_menu_idx == 2 && key_z) {
            global.vol_sfx += 0.1;
            if (global.vol_sfx > 1.05) global.vol_sfx = 0;
            ini_open("configuracoes.ini");
            ini_write_real("Audio", "Volume_SFX", global.vol_sfx);
            ini_close();
            play_beep = true;
        }
        if ((sub_menu_idx == 3 && key_z) || key_x) {
            menu_sub_state = "main";
            play_beep = true;
        }
    } else if (menu_sub_state == "submenu_controls") {
        if (key_z || key_x) { menu_sub_state = "main"; play_beep = true; }
    } else if (menu_sub_state == "submenu_game") {
        if (keyboard_check_pressed(vk_up))   { sub_menu_idx--; if (sub_menu_idx < 0) sub_menu_idx = 2; play_beep = true; }
        if (keyboard_check_pressed(vk_down)) { sub_menu_idx++; if (sub_menu_idx > 2) sub_menu_idx = 0; play_beep = true; }
        if (key_z) {
            play_beep = true;
            if (sub_menu_idx == 0) {
                menu_sub_state = "submenu_save_confirm";
            }
            if (sub_menu_idx == 1) {
                if (file_exists("save.json")) {
                    menu_sub_state = "submenu_load_info";
                } else {
                    shake_continue = 30;
                    error_flash_continue = 45;
                }
            }
            if (sub_menu_idx == 2) menu_sub_state = "main";
        }
        if (key_x) { menu_sub_state = "main"; play_beep = true; }
    } else if (menu_sub_state == "submenu_save_confirm") {
        if (key_z) {
            scr_save_game();
            play_beep = true;
            menu_sub_state = "main";
        }
        if (key_x) {
            menu_sub_state = "submenu_game";
            play_beep = true;
        }
    } else if (menu_sub_state == "submenu_load_info") {
        if (key_z) {
            scr_load_game("save.json");
            play_beep = true;
            menu_sub_state = "main";
        }
        if (key_x) {
            menu_sub_state = "submenu_game";
            play_beep = true;
        }
    } else if (menu_sub_state == "item_box") {
        if (keyboard_check_pressed(vk_up))   { box_selected_opt--; if (box_selected_opt < 0) box_selected_opt = 2; play_beep = true; }
        if (keyboard_check_pressed(vk_down)) { box_selected_opt++; if (box_selected_opt > 2) box_selected_opt = 0; play_beep = true; }
        var current_item = inventory[config_idx];
        if (key_z) {
            play_beep = true;
            if (box_selected_opt == 2 || key_x) { menu_sub_state = "main"; }
            else if (box_selected_opt == 1) { 
                if (current_item.type == "weapon" && equipped_weapon == current_item.name) { equipped_weapon = "NONE"; stat_atk = base_atk; }
                if (current_item.type == "shield" && equipped_shield == current_item.name) { equipped_shield = "NONE"; stat_def = base_def; }
                array_delete(inventory, config_idx, 1);
                config_idx = 0;
                menu_sub_state = "main";
            } else if (box_selected_opt == 0) { 
                if (current_item.type == "weapon") {
                    if (equipped_weapon == current_item.name) { equipped_weapon = "NONE"; stat_atk = base_atk; } 
                    else { equipped_weapon = current_item.name; stat_atk = base_atk + current_item.value; }
                } else if (current_item.type == "shield") {
                    if (equipped_shield == current_item.name) { equipped_shield = "NONE"; stat_def = base_def; } 
                    else { equipped_shield = current_item.name; stat_def = base_def + current_item.value; }
                } else if (current_item.type == "heal") {
                    hp_actual = min(hp_max, hp_actual + current_item.value);
                    array_delete(inventory, config_idx, 1);
                    config_idx = 0;
                }
                menu_sub_state = "main";
            }
        }
        if (key_x) { menu_sub_state = "main"; play_beep = true; }
    }
    if (shake_continue > 0) shake_continue = max(0, shake_continue - 2);
    if (error_flash_continue > 0) error_flash_continue--;
}

if (play_beep) {
    var sfx = audio_play_sound(Beep, 1, false);
    audio_sound_gain(sfx, global.vol_sfx, 0);
}

for (var i = array_length(shatter_particles) - 1; i >= 0; i--) {
    var p = shatter_particles[i]; 
    p.xx += p.vx; 
    p.yy += p.vy; 
    p.vy += 0.2; 
    p.alpha -= 0.02;
    if (p.alpha <= 0) array_delete(shatter_particles, i, 1);
}