var active_sheet = (global.isMila) ? spr_idle_mila : spr_idle;

switch (state) {
    case "walk":  
        active_sheet = (global.isMila) ? spr_walk_mila : spr_walk;  
        break;
        
    case "dash":  
        active_sheet = (global.isMila) ? spr_dash_mila : spr_dash;  
        break;
        
    case "death": 
        active_sheet = (global.isMila) ? spr_death_mila : spr_death; 
        break;
}

if (sprite_exists(sprShadow)) {
    draw_sprite_ext(sprShadow, 0, x, y, 1.6, 1.6, 0, c_white, 1.0);
}

if (sprite_exists(active_sheet)) {
    var frames_por_lado = 8;
    var frame_base = floor(anim_frame) % frames_por_lado;
    var sub_img_real = frame_base + (dir * frames_por_lado);
    draw_sprite_ext(active_sheet, sub_img_real, x, y, 1.6, 1.6, 0, c_white, 1.0);
}