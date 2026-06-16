draw_self();

if (item_equipado != -1) {
    var item_offset_x = 20;
    var item_offset_y = 0;
    
    if (olhando_para == "left") item_offset_x = -20;
    if (olhando_para == "up") item_offset_y = -10;
    if (olhando_para == "down") item_offset_y = 10;
    
    draw_sprite_ext(spr_item_esfera, 0, x + item_offset_x, y + item_offset_y, 0.5, 0.5, 0, c_white, 1.0);
}
