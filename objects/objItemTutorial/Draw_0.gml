draw_self();
if (coletavel) {
    gpu_set_blendmode(bm_add);
    draw_sprite_ext(sprite_index, image_index, x, y, 1.4, 1.4, 0, c_white, 0.4);
    gpu_set_blendmode(bm_normal);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_text(x, y - 20, nome);
}