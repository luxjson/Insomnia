if (state == 0) {
    alpha += speed;
    if (alpha >= 1) {
        alpha = 1;
        state = 1;
        room_goto(target_room);
    }
} else if (state == 1) {
    alpha -= speed;
    if (alpha <= 0) {
        alpha = 0;
        instance_destroy();
    }
}