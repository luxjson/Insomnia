if (debug_mode1) {
    draw_set_color(c_red);
    draw_set_alpha(0.3);
    draw_circle(x, y, trigger_distance, false);
    draw_set_alpha(1);
    draw_rectangle(x - 16, y - 16, x + 16, y + 16, false);
}