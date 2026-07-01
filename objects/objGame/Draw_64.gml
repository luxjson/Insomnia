gpu_set_texfilter(false);
draw_clear(c_black);
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var base_x = gui_w / 2;
draw_set_color(c_aqua);
draw_set_alpha(0.4);
for (var i = 0; i < max_pixels; i++) {
    var px = pixel_list[i].xx;
    var py = pixel_list[i].yy;
    var psize = pixel_list[i].size;
    draw_rectangle(px, py, px + psize - 1, py + psize - 1, false);
}
draw_set_alpha(1.0);
draw_set_color(c_white);
if (current_text_index < array_length(history_texts)) {
    draw_set_font(global.fonteNormal);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    if (show_menu_buttons && !config_open) draw_set_alpha(1.0);
    else draw_set_alpha(text_alpha);
    var is_question = (current_text_index >= 12 && current_text_index <= 24 && current_text_index % 2 == 0);
    var is_game_reply = (current_text_index % 2 != 0 && current_text_index >= 13 && current_text_index <= 25);
    if (current_text_index == array_length(history_texts) - 1) {
        var p1 = "Tomorrow will be a better ";
        var p2 = "DAY.";
        var w1 = string_width(p1) * text_scale;
        var w2 = string_width(p2) * text_scale;
        var total_w = w1 + w2;
        var start_x = base_x - (total_w / 2);
        draw_set_color(c_white);
        draw_text_transformed(start_x + (w1/2), gui_h / 2, p1, text_scale, text_scale, 0);
        draw_set_color(c_yellow);
        draw_text_transformed(start_x + w1 + (w2/2), gui_h / 2, p2, text_scale, text_scale, 0);
    } else if (current_text_index == 8) {
        var p1 = "And honestly? ";
        var p2 = "A quiet part of me didn't care if it hit me.";
        var w1 = string_width(p1) * text_scale;
        var w2 = string_width(p2) * text_scale;
        var total_w = w1 + w2;
        var start_x = base_x - (total_w / 2);
        draw_set_color(c_white);
        draw_text_transformed(start_x + (w1/2), gui_h / 2, p1, text_scale, text_scale, 0);
        draw_set_color(c_aqua);
        draw_text_transformed(start_x + w1 + (w2/2), gui_h / 2, p2, text_scale, text_scale, 0);
    } else if (is_question) {
        draw_set_color(c_aqua);
        draw_text_ext_transformed(base_x, gui_h / 2 - 60, history_texts[current_text_index], 28, gui_w - 200, text_scale, text_scale, 0);
        var q_idx = (current_text_index - 12) / 2;
        var choices = history_choices[q_idx];
        var choice_y_start = gui_h / 2 + 30;
        for (var i = 0; i < 3; i++) {
            draw_set_color(choice_index == i ? c_yellow : c_white);
            var choice_label = choice_index == i ? "> " + choices[i] + " <" : choices[i];
            draw_text_transformed(base_x, choice_y_start + (i * 35), choice_label, text_scale, text_scale, 0);
        }
    } else if (is_game_reply || current_text_index == 26 || current_text_index == 27) {
        draw_set_color(c_aqua);
        draw_text_ext_transformed(base_x, gui_h / 2, history_texts[current_text_index], 28, gui_w - 200, text_scale, text_scale, 0);
    } else {
        draw_set_color(c_white);
        draw_text_ext_transformed(base_x, gui_h / 2, history_texts[current_text_index], 28, gui_w - 200, text_scale, text_scale, 0);
    }
    if (show_skip_prompt) {
        var alpha = 0.5 + sin(current_time / 500) * 0.5;
        draw_set_font(global.fonteLegenda);
        draw_set_halign(fa_center);
        draw_set_valign(fa_bottom);
        draw_set_color(c_white);
        draw_set_alpha(alpha);
        draw_text(gui_w / 2, gui_h - 20, "[X] to skip");
        draw_set_alpha(1);
    }
}
if (show_menu_buttons && !config_open && !is_transitioning) {
    draw_set_font(global.fonteNormal);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_alpha(1.0);
    var menu_start_y = gui_h / 2 - 20;
    var menu_spacing = 45;
    for (var i = 0; i < array_length(main_options); i++) {
        var final_x = base_x;
        var final_y = menu_start_y + (i * menu_spacing);
        var is_load = (main_options[i] == "LOAD SAVE");
        if (is_load && shake_load > 0) final_x += random_range(-shake_load/4, shake_load/4);
        if (is_load && error_flash_load > 0) draw_set_color(c_red);
        else draw_set_color(menu_index == i ? c_aqua : c_white);
        var label = menu_index == i ? "[ " + main_options[i] + " ]" : main_options[i];
        draw_text_transformed(final_x, final_y, label, text_scale, text_scale, 0);
    }
    draw_set_font(global.fonteLegenda);
    draw_set_halign(fa_right);
    draw_set_valign(fa_bottom);
    draw_set_color(c_gray);
    draw_text(gui_w - 20, gui_h - 20, game_version);
}
if (config_y > -350) {
    var box_height = 340;
    draw_set_alpha(1.0);
    draw_set_color(c_black);
    draw_rectangle(50, config_y + 10, gui_w - 50, config_y + 10 + box_height, false);
    draw_set_color(c_aqua);
    draw_line_width(50, config_y + 10, gui_w - 50, config_y + 10, 4);
    draw_line_width(50, config_y + 10 + box_height, gui_w - 50, config_y + 10 + box_height, 4);
    draw_line_width(50, config_y + 10, 50, config_y + 10 + box_height, 4);
    draw_line_width(gui_w - 50, config_y + 10, gui_w - 50, config_y + 10 + box_height, 4);
    draw_set_font(global.fonteNormal);
    draw_set_valign(fa_top);
    var tabs = ["GRAPHICS", "AUDIO", "CONTROLS", "SUPPORT"];
    var t_w = (gui_w - 100) / 4;
    for (var i = 0; i < 4; i++) {
        draw_set_color(config_tab == i ? c_aqua : c_white);
        var tab_label = config_tab == i ? "[ " + tabs[i] + " ]" : tabs[i];
        draw_text(50 + (t_w * i) + (t_w / 2), config_y + 25, tab_label);
    }
    var inner_y = config_y + 80;
    if (config_tab == 0) {
        draw_set_halign(fa_center);
        draw_set_color(config_idx == 0 ? c_aqua : c_white);
        draw_text(base_x, inner_y, "FULLSCREEN: " + (global.fullscreen ? "ON" : "OFF"));
    } else if (config_tab == 1) {
        var opt_text = ["BGM VOLUME: " + string(round(global.vol_bgm * 100)) + "%", "SFX VOLUME: " + string(round(global.vol_sfx * 100)) + "%", "BACK"];
        for (var i = 0; i < 3; i++) {
            draw_set_halign(fa_center);
            draw_set_color(config_idx == i ? c_aqua : c_white);
            draw_text(base_x, inner_y + (i * 45), opt_text[i]);
        }
    } else if (config_tab == 2) {
        draw_set_halign(fa_center);
        draw_set_color(c_white);
        draw_text(base_x, inner_y, "MOVE: ARROW KEYS");
        draw_text(base_x, inner_y + 40, "SPRINT: SHIFT");
        draw_text(base_x, inner_y + 80, "CONFIRM / ACTION: Z");
        draw_text(base_x, inner_y + 120, "CANCEL / BACK: X");
        draw_set_color(make_color_rgb(80, 80, 80));
        draw_text(base_x, inner_y + 180, "[ PRESS X TO RETURN ]");
    } else if (config_tab == 3) {
        draw_set_halign(fa_center);
        draw_set_color(c_white);
        draw_text(base_x, inner_y, "SUPPORT THE GAME");
        draw_set_color(make_color_rgb(160, 160, 160));
        draw_text(base_x, inner_y + 50, "Visit our Itch.io page:");
        draw_set_color(c_yellow);
        draw_text(base_x, inner_y + 90, "https://somiari.itch.io/insomnia");
        draw_set_color(make_color_rgb(160, 160, 160));
        draw_text(base_x, inner_y + 140, "Your support helps us keep developing!");
        draw_set_color(c_white);
        if (config_idx == 0) {
            draw_set_color(c_yellow);
            draw_text(base_x, inner_y + 200, "* VISIT PAGE *");
        } else {
            draw_set_color(c_white);
            draw_text(base_x, inner_y + 200, "VISIT PAGE");
        }
    }
}

if (menu_sub_state == "submenu_load_info") {
    draw_set_color(c_black);
    draw_set_alpha(0.85);
    draw_rectangle(40, config_y + 10, gui_w - 40, config_y + 400, false);
    draw_set_alpha(1.0);
    var box_w = 560;
    var box_h = 280;
    var bx1 = base_x - (box_w / 2);
    var by1 = (gui_h / 2) - (box_h / 2) + config_y;
    var bx2 = base_x + (box_w / 2);
    var by2 = (gui_h / 2) + (box_h / 2) + config_y;
    draw_set_color(c_black);
    draw_rectangle(bx1, by1, bx2, by2, false);
    draw_set_color(c_white);
    draw_rectangle(bx1, by1, bx2, by2, true);
    draw_set_color(c_white);
    draw_line_width(bx1, by1, bx2, by1, 8);
    draw_line_width(bx1, by2, bx2, by2, 8);
    draw_line_width(bx1, by1, bx1, by2, 8);
    draw_line_width(bx2, by1, bx2, by2, 8);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    var ox = bx1 + 50;
    var oy = by1 + 45;
    draw_set_color(c_white);
    draw_text(ox, oy, "* LOAD GAME *");
    if (file_exists("save.json")) {
        var _f = file_text_open_read("save.json");
        var _json = file_text_read_string(_f);
        file_text_close(_f);
        var _data = json_parse(_json);
        draw_set_color(make_color_rgb(180, 180, 180));
        draw_text(ox, oy + 50, "NAME");
        draw_set_color(c_white);
        draw_text(ox + 100, oy + 50, "ABBY");
        draw_set_color(make_color_rgb(180, 180, 180));
        draw_text(ox, oy + 80, "HP");
        draw_set_color(c_white);
        draw_text(ox + 100, oy + 80, string(_data.hp) + "/" + string(_data.hp_max));
        draw_set_color(make_color_rgb(180, 180, 180));
        draw_text(ox, oy + 110, "ITEMS");
        draw_set_color(c_white);
        var inv_count = array_length(_data.inventory);
        draw_text(ox + 100, oy + 110, string(inv_count) + " ITEMS");
        draw_set_color(make_color_rgb(160, 160, 160));
        draw_text(base_x, by2 - 40, "Z - LOAD / X - CANCEL");
    } else {
        draw_set_color(make_color_rgb(80, 80, 80));
        draw_text(ox, oy + 50, "NO SAVE DATA FOUND");
        draw_set_color(make_color_rgb(160, 160, 160));
        draw_text(ox, oy + 90, "PRESS Z OR X TO RETURN");
    }
    draw_set_valign(fa_top);
}

for (var i = 0; i < array_length(shatter_particles); i++) {
    var p = shatter_particles[i];
    draw_set_color(c_red);
    draw_set_alpha(p.alpha);
    draw_rectangle(p.xx, p.yy, p.xx + choose(2,3), p.yy + choose(2,3), false);
}
draw_set_alpha(1.0);
if (is_transitioning) {
    draw_set_color(c_aqua);
    draw_set_alpha(1.0);
    var slice_height = gui_h / slice_count;
    for (var i = 0; i < slice_count; i++) {
        var yy1 = i * slice_height;
        var yy2 = yy1 + slice_height;
        if (i % 2 == 0) draw_rectangle(0, yy1, slice_widths[i], yy2, false);
        else draw_rectangle(gui_w - slice_widths[i], yy1, gui_w, yy2, false);
    }
}
draw_set_alpha(1.0);
draw_set_color(c_white);