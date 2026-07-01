var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var box_w = 520;
var box_h = 540;
var bx1 = (gui_w - box_w) / 2;
var by1 = (gui_h - box_h) / 2;
var bx2 = bx1 + box_w;
var by2 = by1 + box_h;

draw_set_color(c_black);
draw_set_alpha(0.6);
draw_rectangle(0, 0, gui_w, gui_h, false);
draw_set_alpha(1);

draw_set_color(c_black);
draw_rectangle(bx1, by1, bx2, by2, false);
draw_set_color(c_white);
draw_line_width(bx1, by1, bx2, by1, 4);
draw_line_width(bx1, by2, bx2, by2, 4);
draw_line_width(bx1, by1, bx1, by2, 4);
draw_line_width(bx2, by1, bx2, by2, 4);

draw_set_font(global.fonteNormal);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(bx1 + box_w / 2, by1 + 12, "LETTER PUZZLE");

var cell_size = 72;
var grid_w = cell_size * 4;
var grid_h = cell_size * 4;
var grid_x = bx1 + (box_w - grid_w) / 2;
var grid_y = by1 + 60;

for (var r = 0; r < 4; r++) {
    for (var c = 0; c < 4; c++) {
        var xx = grid_x + c * cell_size;
        var yy = grid_y + r * cell_size;
        var val = grid[r][c];
        var col = c_black;
        var txt = "";
        
        if (val == 0) {
            col = c_red;
            txt = "A";
        } else if (val == 1) {
            col = c_blue;
            txt = "M";
        }
        
        draw_set_color(col);
        draw_rectangle(xx, yy, xx + cell_size, yy + cell_size, true);
        
        draw_set_color(c_white);
        draw_line_width(xx, yy, xx + cell_size, yy, 2);
        draw_line_width(xx, yy + cell_size, xx + cell_size, yy + cell_size, 2);
        draw_line_width(xx, yy, xx, yy + cell_size, 2);
        draw_line_width(xx + cell_size, yy, xx + cell_size, yy + cell_size, 2);
        
        draw_set_font(global.fonteTitulo);
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(c_white);
        draw_text(xx + cell_size / 2, yy + cell_size / 2, txt);
    }
}

if (cursor_x >= 0 && cursor_y >= 0 && !focus_buttons && !menu_dir_active) {
    var xx = grid_x + cursor_x * cell_size;
    var yy = grid_y + cursor_y * cell_size;
    draw_set_color(c_yellow);
    draw_set_alpha(0.6);
    draw_rectangle(xx - 3, yy - 3, xx + cell_size + 3, yy + cell_size + 3, false);
    draw_set_alpha(1);
}

draw_set_font(global.fonteLegenda);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(bx1 + box_w / 2, by2 - 80, "ARROWS to move   Z to select   X to cancel");

var button_y = by2 - 52;
var button_w = 100;
var button_h = 28;
var total_w = button_w * 2 + 30;
var start_x = bx1 + (box_w - total_w) / 2;
var labels = ["RESET", "CONFIRM"];
var btn_colors = [c_red, c_lime];

for (var i = 0; i < 2; i++) {
    var xx = start_x + i * (button_w + 30);
    var yy = button_y;
    
    if (focus_buttons && button_selected == i) {
        draw_set_color(c_yellow);
        draw_rectangle(xx - 4, yy - 4, xx + button_w + 4, yy + button_h + 4, false);
    }
    
    draw_set_color(c_black);
    draw_rectangle(xx, yy, xx + button_w, yy + button_h, false);
    draw_set_color(c_white);
    draw_rectangle(xx, yy, xx + button_w, yy + button_h, true);
    
    draw_set_font(global.fonteLegendaM);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(btn_colors[i]);
    draw_text(xx + button_w / 2, yy + button_h / 2, labels[i]);
}

if (message_timer > 0) {
    var alpha = message_timer / 30;
    draw_set_color(c_yellow);
    draw_set_alpha(alpha);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(global.fonteNormal);
    draw_text(bx1 + box_w / 2, by1 + 430, message);
    draw_set_alpha(1);
}

if (menu_dir_active) {
    var menu_w = 270;
    var menu_h = 240;
    var mx1 = (gui_w - menu_w) / 2;
    var my1 = (gui_h - menu_h) / 2;
    var mx2 = mx1 + menu_w;
    var my2 = my1 + menu_h;
    
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(1);
    
    draw_set_color(c_black);
    draw_rectangle(mx1, my1, mx2, my2, false);
    draw_set_color(c_white);
    draw_line_width(mx1, my1, mx2, my1, 4);
    draw_line_width(mx1, my2, mx2, my2, 4);
    draw_line_width(mx1, my1, mx1, my2, 4);
    draw_line_width(mx2, my1, mx2, my2, 4);
    
    draw_set_font(global.fonteNormal);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_text(mx1 + menu_w / 2, my1 + 10, "CHOOSE DIRECTION");
    
    for (var i = 0; i < 4; i++) {
        var yy = my1 + 45 + i * 32;
        if (i == menu_dir_index) {
            draw_set_color(c_yellow);
            draw_text(mx1 + menu_w / 2, yy, "> " + dir_options[i] + " <");
        } else {
            draw_set_color(c_white);
            draw_text(mx1 + menu_w / 2, yy, dir_options[i]);
        }
    }
    
    draw_set_font(global.fonteLegenda);
    draw_set_color(c_gray);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_text(mx1 + menu_w / 2, my2 - 10, "Z - Confirm   X - Cancel");
}