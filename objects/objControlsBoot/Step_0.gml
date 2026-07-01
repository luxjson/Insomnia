var max_opts = array_length(options) - 1;

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

if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter)) {
    audio_play_sound(Beep, 1, false);
    switch (selected_option) {
        case 0:
            with (instance_create_depth(0, 0, -10000, objTransition)) {
                target_room = other.target_menu_room;
            }
            instance_destroy();
            break;
        case 1:
            break;
    }
}

if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift)) {
    audio_play_sound(Select, 1, false);
    
}