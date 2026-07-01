if (state == 0) {
    alpha += speed;
    if (alpha >= 1) {
        alpha = 1;
        state = 1;
        if (room_exists(target_room)) {
            room_goto(target_room);
        } else {
            show_debug_message("Erro: Sala de destino não encontrada!");
            instance_destroy();
        }
    }
}
else if (state == 1) {
    alpha -= speed;
    if (alpha <= 0) {
        alpha = 0;
        instance_destroy();
    }
}