var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

if (status < 3) {
    draw_set_color($1e1ef6);
    draw_rectangle(0, 0, gui_w, gui_h, false);
} else if (status == 3) {
    draw_set_color($1e1ef6);
    draw_set_alpha(menu_fade);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(1.0);
}

if (status == 1 || status == 2) {
    var logo_sprite = spr_logo_estudio;
    var logo_w = sprite_get_width(logo_sprite);
    var escala_500px = 500 / logo_w;
    var logo_x = gui_w / 2;
    var logo_y = gui_h / 2;
    draw_sprite_ext(logo_sprite, 0, logo_x, logo_y, escala_500px, escala_500px, 0, c_white, logo_alpha);
    
    var barra_w = 500;
    var barra_h = 15;
    var barra_x = (gui_w / 2) - (barra_w / 2);
    var barra_y = gui_h - 100;
    
    draw_set_color(c_black);
    draw_set_alpha(logo_alpha * 0.3);
    draw_rectangle(barra_x, barra_y, barra_x + barra_w, barra_y + barra_h, false);
    
    draw_set_color(c_white);
    draw_set_alpha(logo_alpha);
    draw_rectangle(barra_x, barra_y, barra_x + (barra_w * progresso), barra_y + barra_h, false);
    
    draw_set_alpha(1.0);
}

draw_set_color(c_white);