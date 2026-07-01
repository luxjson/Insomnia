if (is_fading) {
    menu_alpha -= fade_speed;
    if (menu_alpha <= 0) {
        menu_alpha = 0;
        if (fade_target_bg != -1) {
            current_bg = fade_target_bg;
            fade_target_bg = -1;
        }
        if (fade_target_room != -1) {
            room_goto(fade_target_room);
            fade_target_room = -1;
        } else if (fade_target_state != -1) {
            current_state = fade_target_state;
            fade_target_state = -1;
            is_fading = false;
            selected_option = 0;
        }
    }
    exit;
}

if (menu_alpha < 1.0) {
    menu_alpha += fade_speed;
    if (menu_alpha > 1.0) menu_alpha = 1.0;
}

var max_opts = 0;
switch (current_state) {
    case MENU_STATE.MAIN: max_opts = array_length(main_options) - 1; break;
    case MENU_STATE.SETTINGS: max_opts = array_length(settings_options) - 1; break;
    case MENU_STATE.CREDITS: max_opts = array_length(credits_text) - 1; break;
}

if (keyboard_check_pressed(vk_up)) {
    selected_option--;
    if (selected_option < 0) selected_option = max_opts;
    audio_play_sound(Beep, 1, false);
}
if (keyboard_check_pressed(vk_down)) {
    selected_option++;
    if (selected_option > max_opts) selected_option = 0;
    audio_play_sound(Beep, 1, false);
}

if (keyboard_check_pressed(ord("X"))) {
    if (current_state == MENU_STATE.SETTINGS || current_state == MENU_STATE.CREDITS) {
        fade_target_state = MENU_STATE.MAIN;
        fade_target_bg = sprMenu;
        is_fading = true;
        selected_option = 0;
        audio_play_sound(Beep, 1, false);
    }
}

if (keyboard_check_pressed(ord("Z"))) {
    audio_play_sound(Beep, 1, false);
    switch (current_state) {
        case MENU_STATE.MAIN:
            switch (selected_option) {
                case 0:
                    with (instance_create_depth(0, 0, -10000, objLoading)) {
                        target_room = rm_Intro;
                    }
                    is_fading = true;
                    break;
                case 1:
                    fade_target_state = MENU_STATE.SETTINGS;
                    is_fading = true;
                    selected_option = 0;
                    break;
                case 2:
                    fade_target_state = MENU_STATE.CREDITS;
                    fade_target_bg = sprCredits;
                    is_fading = true;
                    selected_option = 0;
                    break;
                case 3:
                    game_end();
                    break;
            }
            break;
        case MENU_STATE.SETTINGS:
            switch (selected_option) {
                case 0:
                    global.fullscreen = !global.fullscreen;
                    window_set_fullscreen(global.fullscreen);
                    ini_open("configuracoes.ini");
                    ini_write_real("Video", "Fullscreen", global.fullscreen);
                    ini_close();
                    break;
                case 1:
                    global.vol_bgm += 0.1;
                    if (global.vol_bgm > 1.05) global.vol_bgm = 0;
                    if (audio_is_playing(StartMenu)) {
                        audio_sound_gain(StartMenu, global.vol_bgm, 0);
                    }
                    ini_open("configuracoes.ini");
                    ini_write_real("Audio", "Volume_BGM", global.vol_bgm);
                    ini_close();
                    break;
                case 2:
                    global.vol_sfx += 0.1;
                    if (global.vol_sfx > 1.05) global.vol_sfx = 0;
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
                    fade_target_bg = sprMenu;
                    is_fading = true;
                    selected_option = 0;
                    break;
            }
            break;
        case MENU_STATE.CREDITS:
            if (selected_option == array_length(credits_text) - 1) {
                fade_target_state = MENU_STATE.MAIN;
                fade_target_bg = sprMenu;
                is_fading = true;
                selected_option = 0;
            }
            break;
    }
}