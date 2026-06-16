
draw_self();

if (coletavel) {
    gpu_set_blendmode(bm_add);
   
    draw_sprite_ext(sprite_index, image_index, x, y, 1.4, 1.4, 0, c_white, 0.4);
    
    gpu_set_blendmode(bm_normal);
}