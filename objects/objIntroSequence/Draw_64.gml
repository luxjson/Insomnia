var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var base_x = gui_w / 2;
var base_y = gui_h / 2;

if (alpha > 0) {
    draw_set_alpha(alpha);
    draw_rectangle_color(0, 0, gui_w, gui_h, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
}

if (text_alpha > 0) {
    draw_set_alpha(text_alpha);
    draw_set_font(global.fonteTitulo);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text(base_x, base_y - 20, "INSOMNIA");
    draw_set_alpha(1);
}

if (version_alpha > 0) {
    draw_set_alpha(version_alpha);
    draw_set_font(global.fonteNormal);
    draw_set_halign(fa_left);
    draw_set_valign(fa_bottom);
    draw_set_color(c_gray);
    draw_text(40, gui_h - 40, game_version);
    draw_set_halign(fa_right);
    draw_set_color(c_gray);
    draw_text(gui_w - 40, gui_h - 40, "Created by SOMIARI GAMES");
    draw_set_alpha(1);
}

for (var i = 0; i < array_length(firework_particles); i++) {
    var p = firework_particles[i];
    draw_set_color(c_red);
    draw_set_alpha(p.alpha);
    draw_circle(p.x, p.y, p.size, false);
}
draw_set_alpha(1);

for (var i = 0; i < array_length(explosion_particles); i++) {
    var p = explosion_particles[i];
    draw_set_color(p.color);
    draw_set_alpha(p.alpha);
    draw_rectangle(p.x - p.size/2, p.y - p.size/2, p.x + p.size/2, p.y + p.size/2, true);
}
draw_set_alpha(1);