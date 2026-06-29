if (start_fade) {
    if (fade_alpha < 1) {
        fade_alpha += fade_speed;
    } else {
        show_sleep_text = true;
        if (text_alpha < 1) {
            text_alpha += text_fade_speed;
        } else {
            room_goto(rm_chapter1Initial);
        }
    }
}