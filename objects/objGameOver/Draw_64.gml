gpu_set_texfilter(false);
draw_clear(c_black);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var base_x = gui_w / 2;

for (var i = 0; i < array_length(shatter_particles); i++) {
    var p = shatter_particles[i];
    draw_set_color(p.color);
    draw_set_alpha(p.alpha * text_alpha);
    draw_rectangle(p.xx, p.yy, p.xx + p.size, p.yy + p.size, false);
}
draw_set_alpha(1);

draw_set_font(global.fonteTitulo);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_black);
draw_text_transformed(base_x + 2, gui_h / 2 - 120 + 2, title_text, text_scale * 1.5, text_scale * 1.5, 0);
draw_set_color(c_red);
draw_text_transformed(base_x, gui_h / 2 - 120, title_text, text_scale * 1.5, text_scale * 1.5, 0);

draw_set_font(global.fonteNormal);
draw_set_color(c_silver);
draw_set_alpha(0.8 * text_alpha);
draw_text_ext_transformed(base_x, gui_h / 2 - 40, hope_text, 24, gui_w - 300, text_scale, text_scale, 0);
draw_set_alpha(text_alpha);

var menu_y_start = gui_h / 2 + 60;

for (var i = 0; i < array_length(main_options); i++) {
    var x_pos = base_x;
    var y_pos = menu_y_start + (i * 50);
    
    if (i == 0 && shattered_try) {
        draw_set_color(c_gray);
        draw_text_transformed(x_pos, y_pos, "YOU HAVE NO SAVES LEFT.", text_scale, text_scale, 0);
        continue;
    }
    
    if (i == 0 && shake_try > 0) {
        x_pos += random_range(-shake_try/4, shake_try/4);
    }
    
    if (menu_index == i) {
        draw_set_color(c_white);
        draw_text_transformed(x_pos, y_pos, "> " + main_options[i] + " <", text_scale, text_scale, 0);
    } else {
        draw_set_color(c_gray);
        draw_text_transformed(x_pos, y_pos, main_options[i], text_scale, text_scale, 0);
    }
}

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
        var file_name = "save_" + string(i) + ".json";
        var exists = file_exists(file_name);
        var txt = save_slots[i] + (exists ? " - (CHAPTER " + string(current_chapter) + ")" : " - NO SAVE FOUND");
        
        draw_set_color(save_index == i ? c_aqua : (exists ? c_white : c_gray));
        var final_txt = save_index == i ? "> " + txt + " <" : txt;
        draw_text(base_x, slot_start_y + (i * 40), final_txt);
    }
}

if (is_transitioning) {
    draw_set_alpha(fade_alpha);
    draw_rectangle_color(0, 0, gui_w, gui_h, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
}

for (var i = 0; i < array_length(shatter_particles); i++) {
    var p = shatter_particles[i];
    if (p.alpha < 1) { 
        draw_set_color(p.color);
        draw_set_alpha(p.alpha);
        draw_rectangle(p.xx, p.yy, p.xx + p.size, p.yy + p.size, false);
    }
}
draw_set_alpha(1);
draw_set_color(c_white);