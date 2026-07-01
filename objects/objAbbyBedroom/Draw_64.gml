if (show_objective_text) {
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();
    
    draw_set_font(global.fonteNormal);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var flash = floor(current_time / 500) % 2;
    if (flash == 0) {
        draw_set_color(c_yellow);
    } else {
        draw_set_color(c_white);
    }
    
    draw_text_transformed(gui_w / 2, gui_h - 80, "Walk to the bed to go to sleep", 1.2, 1.2, 0);
}