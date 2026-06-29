switch (state) {
    case 0:
        draw_alpha += speed;
        if (draw_alpha >= 1) {
            draw_alpha = 1;
            state = 1;
            timer = 60 * 2;
        }
        break;
    case 1:
        timer--;
        if (timer <= 0) {
            state = 2;
        }
        break;
    case 2:
        draw_alpha -= speed * 2;
        if (draw_alpha <= 0) {
            draw_alpha = 0;
            state = 3;
            instance_destroy();
        }
        break;
}