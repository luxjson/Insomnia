if (start_fade) {
    var gui_w = display_get_gui_width();
    var gui_h = display_get_gui_height();
    
    draw_set_alpha(fade_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    
    if (show_sleep_text) {
        draw_set_alpha(text_alpha);
        draw_set_font(global.fonteNormal);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(c_white);
        
        draw_text_transformed(gui_w / 2, gui_h / 2, "Falling into deep sleep", 1.5, 1.5, 0);
    }
    
    draw_set_alpha(1.0);
}