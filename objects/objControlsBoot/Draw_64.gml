var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var base_x = gui_w / 2;
var base_y = gui_h / 2;

draw_set_color(c_black);
draw_rectangle(0, 0, gui_w, gui_h, false);

var box_w = 560;
var box_h = 460;
var bx1 = (gui_w - box_w) / 2;
var by1 = (gui_h - box_h) / 2;
var bx2 = bx1 + box_w;
var by2 = by1 + box_h;

draw_set_color(c_black);
draw_set_alpha(0.85);
draw_rectangle(bx1, by1, bx2, by2, false);
draw_set_alpha(1);

draw_set_color(c_white);
draw_line_width(bx1, by1, bx2, by1, 6);
draw_line_width(bx1, by2, bx2, by2, 6);
draw_line_width(bx1, by1, bx1, by2, 6);
draw_line_width(bx2, by1, bx2, by2, 6);

var corner = 12;
draw_rectangle(bx1, by1, bx1 + corner, by1 + corner, true);
draw_rectangle(bx2 - corner, by1, bx2, by1 + corner, true);
draw_rectangle(bx1, by2 - corner, bx1 + corner, by2, true);
draw_rectangle(bx2 - corner, by2 - corner, bx2, by2, true);

draw_set_font(global.fonteNormal);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(base_x, by1 + 20, "CONTROLS");

for (var i = 0; i < array_length(controls_list); i++) {
    var y_pos = by1 + 70 + (i * 32);
    var col = c_white;
    if (i == array_length(controls_list) - 1) col = c_red;
    draw_set_color(col);
    draw_text(base_x, y_pos, controls_list[i]);
}

draw_set_font(global.fonteLegenda);
draw_set_color(c_gray);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_text(base_x, by2 - 12, title_text);

var menu_y = by2 - 100;
for (var i = 0; i < array_length(options); i++) {
    var y_pos = menu_y + (i * 45);
    var txt = options[i];
    if (selected_option == i) {
        draw_set_color(c_yellow);
        txt = "> " + txt + " <";
    } else {
        draw_set_color(c_white);
    }
    draw_set_font(global.fonteNormal);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(base_x, y_pos, txt);
}