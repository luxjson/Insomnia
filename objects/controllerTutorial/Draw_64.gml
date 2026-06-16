var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);
draw_set_color(c_black);
draw_set_alpha(0.7);
draw_rectangle(30, 30, 480, 140, false);
draw_set_alpha(1.0);
draw_set_color(c_white);

if (global.fonteNormal != -1) draw_set_font(global.fonteLegenda);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text_ext(45, 45, texto_guia, 22, 410);

if (status_tutorial >= 4) {
    var hp_w = 200;
    var hp_x = (gui_w / 2) - (hp_w / 2);
    var hp_y = 40;
    draw_set_color(c_red);
    draw_rectangle(hp_x, hp_y, hp_x + hp_w, hp_y + 16, false);
    draw_set_color(c_green);
    draw_rectangle(hp_x, hp_y, hp_x + (hp_w * (player_hp / player_max_hp)), hp_y + 16, false);
    draw_set_color(c_white);
    draw_text(hp_x + hp_w + 15, hp_y, "HP: " + string(player_hp));
}
if (forca_barra > 0) {
    var f_w = 120;
    var f_x = (gui_w / 2) - (f_w / 2);
    var f_y = (gui_h / 2) - 80;
    draw_set_color(c_black);
    draw_rectangle(f_x, f_y, f_x + f_w, f_y + 12, false);
    draw_set_color(c_orange);
    draw_rectangle(f_x, f_y, f_x + (f_w * forca_barra), f_y + 12, false);
    draw_set_color(c_white);
}

if (inventario_aberto) {
    var margin = 40;
    var ix1 = margin;
    var iy1 = gui_h * 0.25;
    var ix2 = gui_w - margin;
    var iy2 = gui_h * 0.75;
    
    draw_set_color(c_white);
    draw_rectangle(ix1, iy1, ix2, iy2, false);
    draw_set_color(c_black);
    draw_rectangle(ix1 + 4, iy1 + 4, ix2 - 4, iy2 - 4, false);
    var slots_total_w = (5 * 100) + (4 * 20);
    var start_sx = (gui_w / 2) - (slots_total_w / 2);
    var sy = (iy1 + iy2) / 2 - 50;
    
    for (var i = 0; i < 5; i++) {
        var sx1 = start_sx + (i * 120);
        var sy1 = sy;
        var sx2 = sx1 + 100;
        var sy2 = sy1 + 100;
        
        draw_set_color(c_white);
        draw_rectangle(sx1, sy1, sx2, sy2, true);
        
        if (i < itens_coletados) {
            if (item_arrastado_index == i) {
                draw_sprite(spr_item_esfera, 0, mx, my);
                
                if (!mouse_check_button(mb_left)) {
                    if (mx < ix1 || mx > ix2 || my < iy1 || my > iy2) {
                        itens_coletados--;
                        itens_removidos_count++;
                        
                        if (instance_exists(objPlayer)) {
                            var drop = instance_create_layer(objPlayer.x + 40, objPlayer.y, "Instances", objItemTutorial);
                            drop.coletavel = true;
                        }
                        
                        if (status_tutorial == 3 && itens_removidos_count >= 1 && itens_coletados == 4) {
                            fade_estado = "fade_out";
                        }
                    }
                    item_arrastado_index = -1;
                }
            } else {
                draw_sprite(spr_item_esfera, 0, sx1 + 50, sy1 + 50);
                
                if (mouse_check_button_pressed(mb_left) && mx >= sx1 && mx <= sx2 && my >= sy1 && my <= sy2) {
                    item_arrastado_index = i;
                }
            }
        }
    }
}
if (status_tutorial < 6 && !exibir_popup) {
    var bw = 220;
    var bh = 60;
    var bx1 = gui_w - bw - 40;
    var by1 = gui_h - bh - 40;
    var bx2 = gui_w - 40;
    var by2 = gui_h - 40;
    
    draw_set_color(c_black);
    draw_rectangle(bx1, by1, bx2, by2, false);
    draw_set_color(c_white);
    draw_rectangle(bx1 + 4, by1 + 4, bx2 - 4, by2 - 4, false);
    if (mx >= bx1 && mx <= bx2 && my >= by1 && my <= by2) {
        draw_set_color(c_dkgray);
        if (mouse_check_button_pressed(mb_left)) exibir_popup = true;
    } else {
        draw_set_color(c_black);
    }
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text((bx1 + bx2) / 2, (by1 + by2) / 2, "PULAR TUTORIAL");
}
if (exibir_popup) {
    var pw = 420;
    var ph = 200;
    var px1 = (gui_w / 2) - (pw / 2);
    var py1 = (gui_h / 2) - (ph / 2);
    var px2 = px1 + pw;
    var py2 = py1 + ph;
    
    draw_set_color(c_white);
    draw_rectangle(px1, py1, px2, py2, false);
    draw_set_color(c_black);
    draw_rectangle(px1 + 4, py1 + 4, px2 - 4, py2 - 4, false);
    
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_text_ext(gui_w / 2, py1 + 25, "Tem certeza?", 24, 380);
    
    var b1x1 = px1 + 40, b1y1 = py2 - 60, b1x2 = px1 + 160, b1y2 = py2 - 20;
    draw_set_color(c_white); draw_rectangle(b1x1, b1y1, b1x2, b1y2, true);
    if (mx >= b1x1 && mx <= b1x2 && my >= b1y1 && my <= b1y2) {
        draw_set_color(c_yellow);
        if (mouse_check_button_pressed(mb_left)) {
            exibir_popup = false;
            status_tutorial = 5;
            fade_estado = "fade_out";
			room_goto(rm_menu)
        }
    } else draw_set_color(c_white);
    draw_text((b1x1 + b1x2) / 2, b1y1 + 10, "SIM");
    
    var b2x1 = px2 - 160, b2y1 = py2 - 60, b2x2 = px2 - 40, b2y2 = py2 - 20;
    draw_set_color(c_white); draw_rectangle(b2x1, b2y1, b2x2, b2y2, true);
    if (mx >= b2x1 && mx <= b2x2 && my >= b2y1 && my <= b2y2) {
        draw_set_color(c_yellow);
        if (mouse_check_button_pressed(mb_left)) exibir_popup = false;
    } else draw_set_color(c_white);
    draw_text((b2x1 + b2x2) / 2, b2y1 + 10, "NÃO");
}

if (fade_alpha > 0) {
    draw_set_color(c_black);
    draw_set_alpha(fade_alpha);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(1.0);
}