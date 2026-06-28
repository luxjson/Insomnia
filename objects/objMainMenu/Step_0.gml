if (is_fading) {
    if (fade_target_state != -1 || fade_target_room != -1) {
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
            }
        }
    }
} else {
    if (menu_alpha < 1.0) {
        menu_alpha += fade_speed;
        if (menu_alpha > 1.0) menu_alpha = 1.0;
    }
}