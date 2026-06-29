if (current_dialogue == -1) exit;

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var box_w = gui_w - 100;
var box_h = 300;
var bx1 = 50;
var by1 = gui_h - box_h - 35;
var bx2 = gui_w - 50;
var by2 = gui_h - 35;

draw_set_color(c_black);
draw_set_alpha(0.7);
draw_rectangle(bx1 + 10, by1 + 10, bx2 + 10, by2 + 10, false);
draw_set_alpha(1);

draw_set_color(c_black);
draw_rectangle(bx1, by1, bx2, by2, false);

draw_set_color(c_white);
draw_line_width(bx1, by1, bx2, by1, 8);
draw_line_width(bx1, by2, bx2, by2, 8);
draw_line_width(bx1, by1, bx1, by2, 8);
draw_line_width(bx2, by1, bx2, by2, 8);

var corner_size = 10;
draw_set_color(c_white);
draw_rectangle(bx1, by1, bx1 + corner_size, by1 + corner_size, true);
draw_rectangle(bx2 - corner_size, by1, bx2, by1 + corner_size, true);
draw_rectangle(bx1, by2 - corner_size, bx1 + corner_size, by2, true);
draw_rectangle(bx2 - corner_size, by2 - corner_size, bx2, by2, true);

var content_x = bx1 + 50;
var content_y = by1 + 35;
var max_text_width = (bx2 - content_x - 45) / 1.3;

if (msg_name != "" && msg_name != "CHOICE") {
    draw_set_font(msg_font);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_yellow);
    draw_text_transformed(content_x, content_y, string_upper(msg_name), 1.4, 1.4, 0);
}

draw_set_color(msg_color);
var text_y_offset = (msg_name != "" && msg_name != "CHOICE") ? 70 : 40;
draw_set_font(msg_font);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text_ext_transformed(content_x, content_y + text_y_offset, displayed_text, 30, max_text_width, 1.3, 1.3, 0);

if (is_choice_mode && !is_typing) {
    var choice_y_start = by1 + 175;
    var choice_spacing = 55;
    var center_x = (bx1 + bx2) / 2;
    
    draw_set_font(msg_font);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var opt1_y = choice_y_start;
    if (choice_selected == 0) {
        draw_set_color(c_yellow);
        draw_text_transformed(center_x - 50, opt1_y, ">", 1.8, 1.8, 0);
        draw_text_transformed(center_x, opt1_y, choice_text_1, 1.3, 1.3, 0);
    } else {
        draw_set_color(c_white);
        draw_text_transformed(center_x, opt1_y, choice_text_1, 1.3, 1.3, 0);
    }
    
    var opt2_y = choice_y_start + choice_spacing;
    if (choice_selected == 1) {
        draw_set_color(c_yellow);
        draw_text_transformed(center_x - 50, opt2_y, ">", 1.8, 1.8, 0);
        draw_text_transformed(center_x, opt2_y, choice_text_2, 1.3, 1.3, 0);
    } else {
        draw_set_color(c_white);
        draw_text_transformed(center_x, opt2_y, choice_text_2, 1.3, 1.3, 0);
    }
}

if (!is_typing && !is_choice_mode) {
    var flash = floor(current_time / 400) % 2;
    if (flash == 0) {
        draw_set_color(c_yellow);
        draw_set_halign(fa_right);
        draw_set_valign(fa_bottom);
        draw_text_transformed(bx2 - 30, by2 - 25, ">", 2.2, 2.2, 0);
    }
}