gpu_set_texfilter(false);

draw_clear(c_black);

var bar_w = 120;
var bar_h = 10;
var bx1 = (gui_w / 2) - (bar_w / 2);
var by1 = gui_h - 50;
var bx2 = (gui_w / 2) + (bar_w / 2);
var by2 = by1 + bar_h;

draw_set_color(c_white);
var fill_w = (load_progress / 100) * bar_w;
draw_rectangle(bx1, by1, bx1 + fill_w, by2, false);

if (fade_alpha > 0) {
    draw_set_color(c_black);
    draw_set_alpha(fade_alpha);
    draw_rectangle(0, 0, gui_w, gui_h, false);
}

draw_set_alpha(1.0);
draw_set_color(c_white);