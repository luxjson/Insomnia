if (fade_state == 0) {
    if (load_progress < 100) {
        load_progress += load_speed;
    } else {
        load_progress = 100;
        is_done = true;
        fade_state = 1;
    }
} else if (fade_state == 1) {
    fade_alpha += 0.02;
    if (fade_alpha >= 1) {
        room_goto(target_room);
    }
}