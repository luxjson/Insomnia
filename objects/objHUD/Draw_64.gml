if (instance_exists(objDialogue)) exit;
if (objPlayer.config_open) exit;
if (global.puzzle_active) exit;
if (instance_exists(objSleepTrigger)) {
	if (objSleepTrigger.sleeping) exit;
}

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

var obj_box_w = 280;
var obj_box_x = gui_w - obj_box_w - 24;
var obj_box_y = 24;

var obj_text = global.current_objective;
if (obj_text == undefined || obj_text == "") obj_text = "Explore the world.";

var text_height = string_height_ext(obj_text, 18, obj_box_w - 24);
var obj_box_h = max(60, text_height + 44);

draw_set_color(c_black);
draw_set_alpha(0.3);
draw_rectangle(obj_box_x + 4, obj_box_y + 4, obj_box_x + obj_box_w + 4, obj_box_y + obj_box_h + 4, false);
draw_set_alpha(1);

draw_set_color(c_black);
draw_set_alpha(0.85);
draw_rectangle(obj_box_x, obj_box_y, obj_box_x + obj_box_w, obj_box_y + obj_box_h, false);
draw_set_alpha(1);

draw_set_color(c_white);
draw_line_width(obj_box_x, obj_box_y, obj_box_x + obj_box_w, obj_box_y, 4);
draw_line_width(obj_box_x, obj_box_y + obj_box_h, obj_box_x + obj_box_w, obj_box_y + obj_box_h, 4);
draw_line_width(obj_box_x, obj_box_y, obj_box_x, obj_box_y + obj_box_h, 4);
draw_line_width(obj_box_x + obj_box_w, obj_box_y, obj_box_x + obj_box_w, obj_box_y + obj_box_h, 4);

var corner = 8;
draw_set_color(c_white);
draw_rectangle(obj_box_x, obj_box_y, obj_box_x + corner, obj_box_y + corner, true);
draw_rectangle(obj_box_x + obj_box_w - corner, obj_box_y, obj_box_x + obj_box_w, obj_box_y + corner, true);
draw_rectangle(obj_box_x, obj_box_y + obj_box_h - corner, obj_box_x + corner, obj_box_y + obj_box_h, true);
draw_rectangle(obj_box_x + obj_box_w - corner, obj_box_y + obj_box_h - corner, obj_box_x + obj_box_w, obj_box_y + obj_box_h, true);

draw_set_font(font_small);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(make_color_rgb(180, 180, 180));
draw_text(obj_box_x + 12, obj_box_y + 6, "OBJECTIVE");

draw_set_color(c_black);
draw_set_alpha(0.3);
draw_text(obj_box_x + 13, obj_box_y + 28, obj_text);
draw_set_alpha(1);

draw_set_font(font_normal);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text_ext(obj_box_x + 12, obj_box_y + 26, obj_text, 18, obj_box_w - 24);