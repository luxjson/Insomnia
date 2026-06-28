gpu_set_texfilter(false);
draw_clear(c_black); 

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var base_x = gui_w / 2;

draw_set_alpha(text_alpha);

draw_set_font(global.fonteNormal);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_red);
draw_text_transformed(base_x, gui_h / 2 - 120, title_text, text_scale * 1.5, text_scale * 1.5, 0);

draw_set_color(c_white);
draw_text_ext_transformed(base_x, gui_h / 2 - 40, hope_text, 24, gui_w - 300, text_scale, text_scale, 0);

var menu_y_start = gui_h / 2 + 60;

if (!shattered_try) {
    var try_x = base_x;
    if (shake_try > 0) try_x += random_range(-shake_try/4, shake_try/4);
    
    draw_set_color(menu_index == 0 ? c_aqua : c_white);
    var label_try = (menu_index == 0) ? "[ " + main_options[0] + " ]" : main_options[0];
    draw_text_transformed(try_x, menu_y_start, label_try, text_scale, text_scale, 0);
} else {
    draw_set_color(c_gray);
    draw_text_transformed(base_x, menu_y_start, "YOU HAVE NO SAVES LEFT.", text_scale, text_scale, 0);
}

draw_set_color(menu_index == 1 ? c_aqua : c_white);
var label_new = (menu_index == 1) ? "[ " + main_options[1] + " ]" : main_options[1];
draw_text_transformed(base_x, menu_y_start + 45, label_new, text_scale, text_scale, 0);

for (var i = 0; i < array_length(shatter_particles); i++) {
    var p = shatter_particles[i];
    draw_set_color(c_red); draw_set_alpha(p.alpha * text_alpha);
    draw_rectangle(p.xx, p.yy, p.xx + choose(2,3), p.yy + choose(2,3), false);
}
draw_set_alpha(text_alpha);

if (save_menu_open) {
    draw_set_alpha(1.0);
    var box_w = 420; var box_h = 240;
    var bx1 = base_x - (box_w / 2); var by1 = (gui_h / 2) - (box_h / 2);
    var bx2 = base_x + (box_w / 2); var by2 = (gui_h / 2) + (box_h / 2);
    
    draw_set_color(c_black); draw_rectangle(bx1, by1, bx2, by2, false);
    draw_set_color(c_aqua);
    draw_line_width(bx1, by1, bx2, by1, 4); draw_line_width(bx1, by2, bx2, by2, 4);
    draw_line_width(bx1, by1, bx1, by2, 4); draw_line_width(bx2, by1, bx2, by2, 4);
    
    draw_set_font(global.fonteNormal); draw_set_halign(fa_center); draw_set_valign(fa_top);
    draw_text(base_x, by1 + 15, "LOAD PREVIOUS PROGRESS");
    
    var slot_start_y = by1 + 70;
    for (var i = 0; i < array_length(save_slots); i++) {
        var file_name = "save_" + string(i) + ".dat";
        var exists = file_exists(file_name);
        var txt = save_slots[i] + (exists ? " - (CHAPTER " + string(current_chapter) + ")" : " - NO SAVE FOUND");
        
        draw_set_color(save_index == i ? c_aqua : (exists ? c_white : c_gray));
        var final_txt = save_index == i ? "> " + txt + " <" : txt;
        draw_text(base_x, slot_start_y + (i * 40), final_txt);
    }
}

if (is_transitioning) {
    draw_set_color(c_aqua); draw_set_alpha(1.0);
    var slice_height = gui_h / slice_count;
    for (var i = 0; i < slice_count; i++) {
        var yy1 = i * slice_height; var yy2 = yy1 + slice_height;
        if (i % 2 == 0) draw_rectangle(0, yy1, slice_widths[i], yy2, false); else draw_rectangle(gui_w - slice_widths[i], yy1, gui_w, yy2, false);
    }
}

draw_set_alpha(1.0);
draw_set_color(c_white);