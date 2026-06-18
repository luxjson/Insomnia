if (dano_timer_player > 0) {
    image_blend = c_red;
    dano_timer_player--;
} else {
    image_blend = c_white;
}
draw_self();
if (item_equipado != -1) {
    var ox = 20, oy = 0;
    if (olhando_para == "left") ox = -20;
    if (olhando_para == "up") oy = -10;
    if (olhando_para == "down") oy = 10;
    draw_sprite_ext(spr_item_esfera, 0, x + ox, y + oy, 0.5, 0.5, 0, c_white, 1.0);
}