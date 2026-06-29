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
        draw_set_color(menu_index == i ? c_aqua : c_white);
        var label = menu_index == i ? "[ " + main_options[i] + " ]" : main_options[i];
        draw_text_transformed(final_x, final_y, label, text_scale, text_scale, 0);
    }
}

if (config_y > -350) {
    draw_set_alpha(1.0);
    draw_set_color(c_black);
    draw_rectangle(50, config_y + 10, gui_w - 50, config_y + 320, false);
    draw_set_color(c_aqua);
    draw_line_width(50, config_y + 10, gui_w - 50, config_y + 10, 4);
    draw_line_width(50, config_y + 320, gui_w - 50, config_y + 320, 4);
    draw_line_width(50, config_y + 10, 50, config_y + 320, 4);
    draw_line_width(gui_w - 50, config_y + 10, gui_w - 50, config_y + 320, 4);

    draw_set_font(global.fonteNormal);
    draw_set_valign(fa_top);
    var tabs = ["GRAPHICS", "GAME", "CONTROLS"];
    var t_w = (gui_w - 100) / 3;
    for (var i = 0; i < 3; i++) {
        draw_set_color(config_tab == i ? c_aqua : c_white);
        var tab_label = config_tab == i ? "[ " + tabs[i] + " ]" : tabs[i];
        draw_text(50 + (t_w * i) + (t_w / 2), config_y + 25, tab_label);
    }

    var inner_y = config_y + 80;
    if (config_tab == 0) {
        var res = resolutions[resolution_index];
        var opt_text = [
            "RESOLUTION: " + string(res[0]) + "x" + string(res[1]),
            "CONTRAST: " + string(round(global.contrast_value * 100)) + "%",
            "TEXT SCALE: " + string(round(text_scale * 100)) + "%"
        ];
        for (var i = 0; i < 3; i++) {
            draw_set_color(config_idx == i ? c_aqua : c_white);
            draw_text(base_x, inner_y + (i * 45), opt_text[i]);
        }
    } else if (config_tab == 1) {
        var opt_text = ["SAVE GAME", "LOAD GAME", "EXIT TO DESKTOP"];
        for (var i = 0; i < 3; i++) {
            draw_set_color(config_idx == i ? c_aqua : c_white);
            draw_text(base_x, inner_y + (i * 45), opt_text[i]);
        }
    } else if (config_tab == 2) {
        for (var i = 0; i < array_length(controls); i++) {
            draw_set_color(config_idx == i ? c_aqua : c_white);
            var k_code = controls[i][1];
            var k_string = "UNKNOWN";
            switch (k_code) {
                case vk_left:  k_string = "LEFT ARROW"; break;
                case vk_right: k_string = "RIGHT ARROW"; break;
                case vk_up:    k_string = "UP ARROW"; break;
                case vk_down:  k_string = "DOWN ARROW"; break;
                case ord("Z"): k_string = "Z"; break;
                case ord("X"): k_string = "X"; break;
                default:       k_string = chr(k_code); break;
            }
            var key_name = is_rebinding && config_idx == i ? "PRESS ANY KEY..." : k_string;
            draw_text(base_x, inner_y + (i * 45), controls[i][0] + ": " + key_name);
        }
    }
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