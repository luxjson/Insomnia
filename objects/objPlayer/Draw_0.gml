if (!morto) {
    if (estado == "dash") {
        draw_sprite_ext(spr_shadow_dash, image_index, x, y, 1, 1, 0, c_white, 0.6);
    } else {
        draw_sprite_ext(spr_shadow, 0, x, y, 1, 1, 0, c_white, 0.5);
    }
}

if (dano_timer_player > 0) {
    image_blend = c_red;
    dano_timer_player--;
} else {
    image_blend = c_white;
}

draw_self();

if (item_equipado != -1 && !morto) {
    var ox = 20, oy = 0;
    if (olhando_para == "left" || olhando_para == "left_down" || olhando_para == "left_up") ox = -20;
    if (olhando_para == "up" || olhando_para == "left_up" || olhando_para == "right_up") oy = -10;
    if (olhando_para == "down" || olhando_para == "left_down" || olhando_para == "right_down") oy = 10;
    draw_sprite_ext(spr_item_esfera, 0, x + ox, y + oy, 0.5, 0.5, 0, c_white, 1.0);
}