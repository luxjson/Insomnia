switch (state) {
    case 0:
        alpha = min(1, alpha + speed);
        slide_offset = min(0, slide_offset + speed * 350);
        if (alpha >= 1) {
            alpha = 1;
            slide_offset = 0;
            state = 1;
            hold_timer = hold_time;
        }
        break;
    case 1:
        hold_timer--;
        if (hold_timer <= 0) {
            state = 2;
        }
        break;
    case 2:
        alpha = max(0, alpha - speed * 0.5);
        if (alpha <= 0) {
            instance_destroy();
        }
        break;
}