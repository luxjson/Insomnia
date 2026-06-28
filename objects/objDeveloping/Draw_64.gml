gpu_set_texfilter(false);
draw_clear(c_black);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var base_x = gui_w / 2;
var font_scale = variable_global_exists("text_scale") ? global.text_scale : 1.0;

for (var i = 0; i < star_count; i++) {
    draw_set_color(c_white);
    draw_set_alpha(star_list[i].alpha);
    var size = (star_list[i].spd > 1.5) ? 2 : 1;
    draw_rectangle(star_list[i].xx, star_list[i].yy, star_list[i].xx + size, star_list[i].yy + size, false);
}
draw_set_alpha(1.0);

if (game_state == MINIGAME_STATE.INTRO) {
    draw_set_font(global.fonteNormal); draw_set_halign(fa_center); draw_set_valign(fa_middle);
    if (!show_choice_menu) {
        draw_set_alpha(text_alpha);
        if (current_text_index == 0) {
            var p1 = "ATTENTION: This sector of the game is currently under "; var p2 = "DEVELOPMENT.";
            var w1 = string_width(p1) * font_scale; var w2 = string_width(p2) * font_scale;
            var total_w = w1 + w2; var start_x = base_x - (total_w / 2);
            draw_set_color(c_white); draw_text_transformed(start_x + (w1/2), gui_h / 2, p1, font_scale, font_scale, 0);
            draw_set_color(c_yellow); draw_text_transformed(start_x + w1 + (w2/2), gui_h / 2, p2, font_scale, font_scale, 0);
        }
        else if (current_text_index == 2) {
            var p1 = "You can wait for future "; var p2 = "UPDATES "; var p3 = "or test our current systems.";
            var w1 = string_width(p1) * font_scale; var w2 = string_width(p2) * font_scale; var w3 = string_width(p3) * font_scale;
            var total_w = w1 + w2 + w3; var start_x = base_x - (total_w / 2);
            draw_set_color(c_white); draw_text_transformed(start_x + (w1/2), gui_h / 2, p1, font_scale, font_scale, 0);
            draw_set_color(c_yellow); draw_text_transformed(start_x + w1 + (w2/2), gui_h / 2, p2, font_scale, font_scale, 0);
            draw_set_color(c_white); draw_text_transformed(start_x + w1 + w2 + (w3/2), gui_h / 2, p3, font_scale, font_scale, 0);
        }
        else if (current_text_index == 3) {
            var p1 = "While we finish this area, you can play a quick arcade "; var p2 = "MINIGAME.";
            var w1 = string_width(p1) * font_scale; var w2 = string_width(p2) * font_scale;
            var total_w = w1 + w2; var start_x = base_x - (total_w / 2);
            draw_set_color(c_white); draw_text_transformed(start_x + (w1/2), gui_h / 2, p1, font_scale, font_scale, 0);
            draw_set_color(c_yellow); draw_text_transformed(start_x + w1 + (w2/2), gui_h / 2, p2, font_scale, font_scale, 0);
        } else {
            draw_set_color(c_white); draw_text_ext_transformed(base_x, gui_h / 2, dev_texts[current_text_index], 28, gui_w - 200, font_scale, font_scale, 0);
        }
    } else {
        draw_set_alpha(1.0); draw_set_color(c_aqua); draw_text_transformed(base_x, gui_h / 2 - 80, "SELECT AN OPTION:", font_scale, font_scale, 0);
        for (var i = 0; i < 2; i++) {
            draw_set_color(choice_index == i ? c_yellow : c_white);
            var lbl = (choice_index == i) ? "> " + menu_options[i] + " <" : menu_options[i];
            draw_text_transformed(base_x, gui_h / 2 + (i * 45), lbl, font_scale, font_scale, 0);
        }
    }
}

if (game_state == MINIGAME_STATE.PLAYING) {
    draw_set_alpha(1.0);
    
    draw_set_font(global.fonteNormal); draw_set_halign(fa_left); draw_set_valign(fa_top);
    draw_set_color(c_white); draw_text_transformed(30, 20, "SCORE: " + string(score_points) + " / 1000", font_scale, font_scale, 0);
    draw_set_halign(fa_right); draw_set_color(c_aqua); draw_text_transformed(gui_w - 30, 20, "SHIELD: " + string(player_lives), font_scale, font_scale, 0);
    
    if (player_x != player_last_x) {
        draw_set_alpha(0.3); draw_set_color(c_teal);
        
        draw_primitive_begin(pr_trianglestrip);
        draw_vertex(player_last_x, player_y - 12);
        draw_vertex(player_last_x - 14, player_y + 10);
        draw_vertex(player_last_x + 14, player_y + 10);
        draw_primitive_end();
    }
    
    draw_set_alpha(1.0); draw_set_color(c_aqua);
    draw_primitive_begin(pr_trianglestrip);
    draw_vertex(player_x, player_y - 14); 
    draw_vertex(player_x - 12, player_y + 8);
    draw_vertex(player_x + 12, player_y + 8);
    draw_primitive_end();
    draw_set_color(c_aqua);
    draw_rectangle(player_x - 15, player_y + 4, player_x - 11, player_y + 8, false);
    draw_rectangle(player_x + 11, player_y + 4, player_x + 15, player_y + 8, false);
    
    for(var i = 0; i < array_length(player_lasers); i++) {
        var l = player_lasers[i];
        draw_set_color(c_yellow); draw_set_alpha(0.4);
        draw_line_width(l.xx, l.yy + 2, l.xx, l.yy - 10, 5);
        draw_set_color(c_white); draw_set_alpha(1.0);
        draw_line_width(l.xx, l.yy, l.xx, l.yy - 8, 2);
    }
    
    for(var i = 0; i < array_length(enemies); i++) {
        var e = enemies[i];
        var pulse_size = sin(e.pulse) * 3;
        
        draw_set_alpha(1.0); draw_set_color(c_red);
        draw_primitive_begin(pr_trianglestrip);
        draw_vertex(e.xx, e.yy - 10);
        draw_vertex(e.xx - 10 - pulse_size, e.yy);
        draw_vertex(e.xx + 10 + pulse_size, e.yy);
        draw_vertex(e.xx, e.yy + 10);
        draw_primitive_end();
        
        draw_set_color(c_yellow);
        draw_circle(e.xx - 4, e.yy - 2, 2, false);
        draw_circle(e.xx + 4, e.yy - 2, 2, false);
    }
    
    for(var i = 0; i < array_length(enemy_lasers); i++) {
        var el = enemy_lasers[i];
        draw_set_color(c_orange); draw_set_alpha(0.4);
        draw_circle(el.xx, el.yy, 6, false); 
        draw_set_color(c_red); draw_set_alpha(1.0);
        draw_circle(el.xx, el.yy, 3, false);
    }
}

if (game_state == MINIGAME_STATE.GAMEOVER) {
    draw_set_color(c_black); draw_set_alpha(0.6); draw_rectangle(0,0, gui_w, gui_h, false);
    draw_set_alpha(1.0);
    var box_w = 460; var box_h = 260;
    var bx1 = base_x - (box_w / 2); var by1 = (gui_h / 2) - (box_h / 2);
    var bx2 = base_x + (box_w / 2); var by2 = (gui_h / 2) + (box_h / 2);
    
    draw_set_color(c_black); draw_rectangle(bx1, by1, bx2, by2, false);
    draw_set_color(c_red);
    draw_line_width(bx1, by1, bx2, by1, 4); draw_line_width(bx1, by2, bx2, by2, 4);
    draw_line_width(bx1, by1, bx1, by2, 4); draw_line_width(bx2, by1, bx2, by2, 4);
    
    draw_set_font(global.fonteNormal); draw_set_halign(fa_center); draw_set_valign(fa_top);
    draw_text_transformed(base_x, by1 + 20, "MINIGAME OVER", font_scale * 1.2, font_scale * 1.2, 0);
    
    draw_set_color(c_white);
    draw_text_ext_transformed(base_x, by1 + 75, "Your defenses fell, but the simulation can be run again.", 20, box_w - 40, font_scale, font_scale, 0);
    
    for (var i = 0; i < 2; i++) {
        draw_set_color(end_menu_index == i ? c_yellow : c_white);
        var lbl = (end_menu_index == i) ? "> " + gameover_options[i] + " <" : gameover_options[i];
        draw_text_transformed(base_x, by1 + 150 + (i * 40), lbl, font_scale, font_scale, 0);
    }
}

if (game_state == MINIGAME_STATE.VICTORY) {
    draw_set_color(c_black); draw_set_alpha(0.8); draw_rectangle(0,0, gui_w, gui_h, false);
    draw_set_alpha(1.0);
    draw_set_font(global.fonteNormal); draw_set_halign(fa_center); draw_set_valign(fa_top);
    
    draw_set_color(c_yellow); draw_text_transformed(base_x, gui_h / 2 - 160, "CONGRATULATIONS!", font_scale * 1.4, font_scale * 1.4, 0);
    draw_set_color(c_white); draw_text_transformed(base_x, gui_h / 2 - 100, "FINAL SCORE: " + string(score_points) + " PTS", font_scale, font_scale, 0);
    
    draw_set_color(c_aqua);
    var dev_msg = "Thank you for navigating through our unfinished horizons. Your persistence is what brings color and code back into our worlds. Stay close, we are crafting the future step by step.";
    draw_text_ext_transformed(base_x, gui_h / 2 - 40, dev_msg, 24, gui_w - 240, font_scale, font_scale, 0);
    
    var btn_start_y = gui_h / 2 + 100;
    for (var i = 0; i < 2; i++) {
        draw_set_color(end_menu_index == i ? c_yellow : c_white);
        var lbl = (end_menu_index == i) ? "[ " + victory_options[i] + " ]" : victory_options[i];
        draw_text_transformed(base_x, btn_start_y + (i * 45), lbl, font_scale, font_scale, 0);
    }
}

draw_set_alpha(1.0); draw_set_color(c_white);