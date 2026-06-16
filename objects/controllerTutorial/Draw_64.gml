var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

draw_set_color(c_black);
draw_rectangle(0, 0, gui_w, 40, false);
draw_set_color(c_white);
draw_rectangle(0, 38, gui_w, 40, false);

if (global.fonteNormal != -1) draw_set_font(global.fonteLegenda);
draw_set_color(c_white);
draw_set_alpha(1.0);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

letreiro_x -= letreiro_velocidade;
var texto_w = string_width(texto_guia);
if (letreiro_x < -texto_w) {
    letreiro_x = gui_w;
}
draw_text(letreiro_x, 20, texto_guia);

var hp_x = 40;
var hp_y = gui_h - 100;

if (modo_combate) {
    var f_w = 150;
    var f_h = 60;
    var f_x = hp_x;
    var f_y = hp_y - f_h - 15;
    
    draw_set_color(c_black);
    draw_rectangle(f_x, f_y, f_x + f_w, f_y + f_h, false);
    draw_set_color(c_white);
    draw_rectangle(f_x + 3, f_y + 3, f_x + f_w - 3, f_y + f_h - 3, true);
    draw_set_color(c_black);
    draw_rectangle(f_x + 5, f_y + 5, f_x + f_w - 5, f_y + f_h - 5, true);
    
    draw_set_color(c_red);
    draw_rectangle(f_x + 6, f_y + 6, f_x + f_w - 6, f_y + f_h - 6, false);
    
    draw_set_color(c_white);
    draw_rectangle(f_x + 6 + ((f_w - 12) * 0.75), f_y + 6, f_x + 6 + ((f_w - 12) * 0.95), f_y + f_h - 6, false);
    
    draw_set_color(c_black);
    draw_rectangle(f_x + 6 + ((f_w - 12) * forca_barra), f_y + 6, f_x + 6 + ((f_w - 12) * forca_barra) + 4, f_y + f_h - 6, false);
}

if (status_tutorial >= 4) {
    var hp_w = 150;
    var hp_h = 60;
    draw_set_color(c_black);
    draw_rectangle(hp_x, hp_y, hp_x + hp_w, hp_y + hp_h, false);
    draw_set_color(c_white);
    draw_rectangle(hp_x + 3, hp_y + 3, hp_x + hp_w - 3, hp_y + hp_h - 3, true);
    draw_set_color(c_black);
    draw_rectangle(hp_x + 5, hp_y + 5, hp_x + hp_w - 5, hp_y + hp_h - 5, true);
    
    draw_set_color(c_red);
    draw_rectangle(hp_x + 6, hp_y + 6, hp_x + hp_w - 6, hp_y + hp_h - 6, false);
    draw_set_color(c_green);
    draw_rectangle(hp_x + 6, hp_y + 6, hp_x + 6 + ((hp_w - 12) * (player_hp / player_max_hp)), hp_y + hp_h - 6, false);
    
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(hp_x + (hp_w / 2), hp_y + (hp_h / 2), "HP: " + string(player_hp));
}

if (texto_combo_alpha > 0) {
    draw_set_alpha(clamp(texto_combo_alpha, 0, 1));
    draw_set_color(c_black);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text((gui_w / 2) + 2, (gui_h / 2) - 150 + 2, texto_combo);
    if (dano_aplicado > 0) draw_text((gui_w / 2) + 2, (gui_h / 2) - 110 + 2, "+" + string(dano_aplicado) + " DANO");
    
    if (combo_atual == 1) draw_set_color(c_white);
    else if (combo_atual == 2) draw_set_color(c_yellow);
    else if (combo_atual >= 3) draw_set_color(c_orange);
    else draw_set_color(c_red);
    
    draw_text(gui_w / 2, (gui_h / 2) - 150, texto_combo);
    if (dano_aplicado > 0) draw_text(gui_w / 2, (gui_h / 2) - 110, "+" + string(dano_aplicado) + " DANO");
    draw_set_alpha(1.0);
}

if (menu_aberto) {
    menu_y_anim = lerp(menu_y_anim, 60, 0.15);
} else {
    menu_y_anim = lerp(menu_y_anim, -gui_h, 0.15);
}

if (delay_entrada > 0) delay_entrada--;
if (delay_submenu > 0) delay_submenu--;

if (menu_y_anim > -gui_h + 5) {
    var m_x1 = 60;
    var m_y1 = menu_y_anim;
    var m_x2 = gui_w - 60;
    var m_y2 = menu_y_anim + (gui_h - 120);
    
    draw_set_color(c_black);
    draw_rectangle(m_x1, m_y1, m_x2, m_y2, false);
    draw_set_color(c_white);
    draw_rectangle(m_x1 + 3, m_y1 + 3, m_x2 - 3, m_y2 - 3, true);
    draw_set_color(c_black);
    draw_rectangle(m_x1 + 5, m_y1 + 5, m_x2 - 5, m_y2 - 5, true);
    
    if (menu_aberto && sub_menu_estado == "normal" && delay_entrada == 0) {
        if (keyboard_check_pressed(ord("X"))) {
            foco_aba = true;
            menu_opcao_vertical = 0;
            slot_inv_selecionado = 0;
        }
        if (keyboard_check_pressed(ord("Z"))) {
            if (foco_aba) {
                foco_aba = false;
                delay_entrada = 30;
                menu_opcao_vertical = 0;
                slot_inv_selecionado = 0;
            }
        }
        if (foco_aba) {
            if (keyboard_check_pressed(vk_right)) { aba_selecionada = (aba_selecionada + 1) % 4; }
            if (keyboard_check_pressed(vk_left)) { aba_selecionada = (aba_selecionada + 3) % 4; }
        } else {
            if (aba_selecionada == 0) {
                if (keyboard_check_pressed(vk_down)) menu_opcao_vertical = (menu_opcao_vertical + 1) % 4;
                if (keyboard_check_pressed(vk_up)) menu_opcao_vertical = (menu_opcao_vertical + 3) % 4;
            }
            if (aba_selecionada == 1) {
                if (keyboard_check_pressed(vk_right)) slot_inv_selecionado = (slot_inv_selecionado + 1) % 5;
                if (keyboard_check_pressed(vk_left)) slot_inv_selecionado = (slot_inv_selecionado + 4) % 5;
            }
            if (aba_selecionada == 2) {
                if (keyboard_check_pressed(vk_down)) menu_opcao_vertical = (menu_opcao_vertical + 1) % 4;
                if (keyboard_check_pressed(vk_up)) menu_opcao_vertical = (menu_opcao_vertical + 3) % 4;
            }
        }
    }
    
    var abas = ["JOGO", "INVENTÁRIO", "CONFIG", "CONQUISTAS"];
    for (var a = 0; a < 4; a++) {
        var ax = m_x1 + 50 + (a * 180);
        var ay = m_y1 + 40;
        if (a == aba_selecionada && foco_aba) draw_set_color(c_yellow);
        else draw_set_color(c_white);
        draw_set_halign(fa_left);
        draw_text(ax, ay, abas[a]);
    }
    
    draw_set_color(c_white);
    draw_line(m_x1 + 20, m_y1 + 80, m_x2 - 20, m_y1 + 80);
    
    var content_y = m_y1 + 130;
    
    if (aba_selecionada == 0) {
        if (sub_menu_estado == "normal") {
            var opcoes_jogo = ["NOVO JOGO", "SALVAR JOGO", "CARREGAR JOGO", "EXCLUIR JOGO"];
            if (menu_aberto && !foco_aba && delay_entrada == 0) {
                if (keyboard_check_pressed(ord("Z"))) {
                    if (menu_opcao_vertical == 0) {
                        room_restart();
                    }
                    if (menu_opcao_vertical == 1) { sub_menu_estado = "save_slots"; menu_save_tipo = "salvar"; slot_selecionado = 0; }
                    if (menu_opcao_vertical == 2) { sub_menu_estado = "save_slots"; menu_save_tipo = "carregar"; slot_selecionado = 0; }
                    if (menu_opcao_vertical == 3) { sub_menu_estado = "save_slots"; menu_save_tipo = "excluir"; slot_selecionado = 0; }
                }
            }
            for (var o = 0; o < 4; o++) {
                if (o == menu_opcao_vertical && !foco_aba) draw_set_color(c_yellow);
                else draw_set_color(c_white);
                draw_text(m_x1 + 50, content_y + (o * 50), opcoes_jogo[o]);
            }
        }
        else if (sub_menu_estado == "save_slots") {
            if (menu_aberto) {
                if (keyboard_check_pressed(vk_down)) slot_selecionado = (slot_selecionado + 1) % 3;
                if (keyboard_check_pressed(vk_up)) slot_selecionado = (slot_selecionado + 2) % 3;
                if (keyboard_check_pressed(ord("X"))) sub_menu_estado = "normal";
                if (keyboard_check_pressed(ord("Z"))) {
                    var filename = "save_slot_" + string(slot_selecionado) + ".ini";
                    if (menu_save_tipo == "salvar") {
                        ini_open(filename);
                        ini_write_real("Player", "HP", player_hp);
                        ini_write_real("Player", "MaxHP", player_max_hp);
                        if (instance_exists(objPlayer)) {
                            ini_write_real("Player", "X", objPlayer.x);
                            ini_write_real("Player", "Y", objPlayer.y);
                        }
                        ini_write_real("Progress", "Itens", itens_coletados);
                        ini_close();
                        sub_menu_estado = "normal";
                    }
                    if (menu_save_tipo == "carregar" && file_exists(filename)) {
                        ini_open(filename);
                        player_hp = ini_read_real("Player", "HP", 100);
                        player_max_hp = ini_read_real("Player", "MaxHP", 100);
                        if (instance_exists(objPlayer)) {
                            objPlayer.x = ini_read_real("Player", "X", objPlayer.x);
                            objPlayer.y = ini_read_real("Player", "Y", objPlayer.y);
                        }
                        itens_coletados = ini_read_real("Progress", "Itens", 0);
                        ini_close();
                        sub_menu_estado = "normal";
                    }
                    if (menu_save_tipo == "excluir") {
                        if (file_exists(filename)) file_delete(filename);
                        sub_menu_estado = "normal";
                    }
                }
            }
            for (var s = 0; s < 3; s++) {
                var filename = "save_slot_" + string(s) + ".ini";
                var slot_text = "SLOT " + string(s + 1) + ": ";
                if (file_exists(filename)) {
                    ini_open(filename);
                    var hp_salvo = ini_read_real("Player", "HP", 0);
                    var item_salvo = ini_read_real("Progress", "Itens", 0);
                    ini_close();
                    slot_text += "HP " + string(hp_salvo) + " | ITENS: " + string(item_salvo);
                } else {
                    slot_text += "Nenhum jogo emcontrdo";
                }
                if (s == slot_selecionado) {
                    if (menu_save_tipo == "excluir") draw_set_color(c_red);
                    else draw_set_color(c_yellow);
                } else draw_set_color(c_white);
                draw_rectangle(m_x1 + 50, content_y + (s * 90), m_x2 - 50, content_y + (s * 90) + 70, true);
                draw_text(m_x1 + 70, content_y + (s * 90) + 35, slot_text);
            }
        }
    }
    
    if (aba_selecionada == 1) {
        var slot_size = 80;
        var start_sx = m_x1 + 50;
        if (sub_menu_estado == "normal" && menu_aberto && !foco_aba && delay_entrada == 0) {
            if (keyboard_check_pressed(ord("Z")) && slot_inv_selecionado < itens_coletados) {
                sub_menu_estado = "drop_confirm";
                item_sub_opcao = 0;
                delay_submenu = 30;
            }
        }
        for (var i = 0; i < 5; i++) {
            var sx1 = start_sx + (i * 110);
            var sy1 = content_y;
            var sx2 = sx1 + slot_size;
            var sy2 = sy1 + slot_size;
            if (i == slot_inv_selecionado && !foco_aba && sub_menu_estado == "normal") draw_set_color(c_yellow);
            else draw_set_color(c_white);
            draw_rectangle(sx1, sy1, sx2, sy2, true);
            if (i < itens_coletados) {
                draw_sprite_ext(spr_item_esfera, 0, sx1 + 40, sy1 + 40, 1, 1, 0, c_white, 1);
            }
        }
        if (sub_menu_estado == "drop_confirm") {
    var p_w = 300, p_h = 160;
    var px1 = (gui_w / 2) - (p_w / 2), py1 = (gui_h / 2) - (p_h / 2);
    var px2 = px1 + p_w, py2 = py1 + p_h;
    draw_set_color(c_black); draw_rectangle(px1, py1, px2, py2, false);
    draw_set_color(c_white); draw_rectangle(px1 + 3, py1 + 3, px2 - 3, py2 - 3, true);
    draw_set_color(c_black); draw_rectangle(px1 + 5, py1 + 5, px2 - 5, py2 - 5, true);
    
    if (menu_aberto && delay_submenu == 0) {
        if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(vk_up)) {
            item_sub_opcao = (item_sub_opcao + 1) % 2;
        }
        if (keyboard_check_pressed(ord("Z"))) {
            if (item_sub_opcao == 0) {

                itens_coletados--;
                itens_removidos_count++;
                
                if (instance_exists(objPlayer)) {
                    var drop = instance_create_layer(objPlayer.x + 40, objPlayer.y, "Instances", objItemTutorial);
                    drop.coletavel = true;
                }️
                if (status_tutorial == 3 && itens_removidos_count >= 1 && itens_coletados == 4) {
                    fade_estado = "fade_out";
                }
            }
            sub_menu_estado = "normal";
            delay_submenu = 0;
        }
    }
    
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_text(gui_w / 2, py1 + 30, "AÇÃO DO ITEM");
    
    if (item_sub_opcao == 0) draw_set_color(c_yellow); else draw_set_color(c_white);
    draw_text(gui_w / 2, py1 + 80, "DROP");
    
    if (item_sub_opcao == 1) draw_set_color(c_yellow); else draw_set_color(c_white);
    draw_text(gui_w / 2, py1 + 120, "CANCELAR");
}
    }
    
    if (aba_selecionada == 2) {
        if (menu_aberto && !foco_aba && delay_entrada == 0) {
            if (keyboard_check_pressed(ord("Z"))) {
                if (menu_opcao_vertical == 0) {
                    fullscreen = !fullscreen;
                    window_set_fullscreen(fullscreen);
                    ini_open("configuracoes.ini");
                    ini_write_real("Video", "Fullscreen", fullscreen);
                    ini_close();
                }
                if (menu_opcao_vertical == 1) {
                    audio_volume += 0.1;
                    if (audio_volume > 1.05) audio_volume = 0;
                    audio_master_gain(audio_volume);
                    ini_open("configuracoes.ini");
                    ini_write_real("Audio", "Volume", audio_volume);
                    ini_close();
                }
                if (menu_opcao_vertical == 2) {
                    achievements_enabled = !achievements_enabled;
                    ini_open("configuracoes.ini");
                    ini_write_real("Gameplay", "Achievements", achievements_enabled);
                    ini_close();
                }
                if (menu_opcao_vertical == 3) {
                    room_goto(rm_menu);
                }
            }
        }
        var txt_fs = "FULLSCREEN: " + (fullscreen ? "ON" : "OFF");
        var txt_au = "AUDIO: " + string(round(audio_volume * 100)) + "%";
        var txt_ac = "ACHIEVEMENTS: " + (achievements_enabled ? "ENABLED" : "DISABLED");
        var txt_bk = "BACK TO MENU";
        var cfg_txts = [txt_fs, txt_au, txt_ac, txt_bk];
        for (var c = 0; c < 4; c++) {
            if (c == menu_opcao_vertical && !foco_aba) draw_set_color(c_yellow);
            else draw_set_color(c_white);
            draw_text(m_x1 + 50, content_y + (c * 50), cfg_txts[c]);
        }
    }
    
    if (aba_selecionada == 3) {
        var slot_w = 80, slot_h = 80;
        var cols = 6;
        var start_cx = m_x1 + 50;
        for (var k = 0; k < 12; k++) {
            var col = k % cols;
            var row = floor(k / cols);
            var kx1 = start_cx + (col * 110);
            var ky1 = content_y + (row * 110);
            draw_set_color(c_white);
            draw_rectangle(kx1, ky1, kx1 + slot_w, ky1 + slot_h, true);
            draw_set_halign(fa_center); draw_set_valign(fa_middle);
            draw_text(kx1 + (slot_w / 2), ky1 + (slot_h / 2), "?");
        }
    }
}

if (status_tutorial < 6 && !exibir_popup) {
    var bw = 220, bh = 60;
    var bx1 = gui_w - bw - 40, by1 = gui_h - bh - 40;
    var bx2 = gui_w - 40, by2 = gui_h - 40;
    var m_sobre_botao = (mx >= bx1 && mx <= bx2 && my >= by1 && my <= by2);
    if (m_sobre_botao) {
        draw_set_color(c_white); draw_rectangle(bx1, by1, bx2, by2, false);
        draw_set_color(c_black); draw_rectangle(bx1 + 3, by1 + 3, bx2 - 3, by2 - 3, true);
        draw_set_color(c_white); draw_rectangle(bx1 + 5, by1 + 5, bx2 - 5, by2 - 5, true);
        draw_set_color(c_black);
        if (mouse_check_button_pressed(mb_left)) exibir_popup = true;
    } else {
        draw_set_color(c_black); draw_rectangle(bx1, by1, bx2, by2, false);
        draw_set_color(c_white); draw_rectangle(bx1 + 3, by1 + 3, bx2 - 3, by2 - 3, true);
        draw_set_color(c_black); draw_rectangle(bx1 + 5, by1 + 5, bx2 - 5, by2 - 5, true);
        draw_set_color(c_white);
    }
    draw_set_halign(fa_center); draw_set_valign(fa_middle);
    draw_text((bx1 + bx2) / 2, (by1 + by2) / 2, "PULAR TUTORIAL");
}

if (exibir_popup) {
    var pw = 420, ph = 200;
    var px1 = (gui_w / 2) - (pw / 2), py1 = (gui_h / 2) - (ph / 2);
    var px2 = px1 + pw, py2 = py1 + ph;
    draw_set_color(c_black); draw_rectangle(px1, py1, px2, py2, false);
    draw_set_color(c_white); draw_rectangle(px1 + 3, py1 + 3, px2 - 3, py2 - 3, true);
    draw_set_color(c_black); draw_rectangle(px1 + 5, py1 + 5, px2 - 5, py2 - 5, true);
    draw_set_color(c_white); draw_set_halign(fa_center); draw_set_valign(fa_top);
    draw_text_ext(gui_w / 2, py1 + 25, "Tem certeza?", 24, 380);
    
    var b1x1 = px1 + 40, b1y1 = py2 - 60, b1x2 = px1 + 160, b1y2 = py2 - 20;
    var m_sobre_b1 = (mx >= b1x1 && mx <= b1x2 && my >= b1y1 && my <= b1y2);
    if (m_sobre_b1) {
        draw_set_color(c_white); draw_rectangle(b1x1, b1y1, b1x2, b1y2, false);
        draw_set_color(c_black); draw_rectangle(b1x1 + 3, b1y1 + 3, b1x2 - 3, b1y2 - 3, true);
        draw_set_color(c_white); draw_rectangle(b1x1 + 5, b1y1 + 5, b1x2 - 5, b1y2 - 5, true);
        draw_set_color(c_black);
        if (mouse_check_button_pressed(mb_left)) {
            exibir_popup = false;
            status_tutorial = 5;
            fade_estado = "fade_out";
            room_goto(rm_menu);
        }
    } else {
        draw_set_color(c_black); draw_rectangle(b1x1, b1y1, b1x2, b1y2, false);
        draw_set_color(c_white); draw_rectangle(b1x1 + 3, b1y1 + 3, b1x2 - 3, b1y2 - 3, true);
        draw_set_color(c_black); draw_rectangle(b1x1 + 5, b1y1 + 5, b1x2 - 5, b1y2 - 5, true);
        draw_set_color(c_white);
    }
    draw_set_halign(fa_center); draw_set_valign(fa_middle);
    draw_text((b1x1 + b1x2) / 2, (b1y1 + b1y2) / 2, "SIM");
    
    var b2x1 = px2 - 160, b2y1 = py2 - 60, b2x2 = px2 - 40, b2y2 = py2 - 20;
    var m_sobre_b2 = (mx >= b2x1 && mx <= b2x2 && my >= b2y1 && my <= b2y2);
    if (m_sobre_b2) {
        draw_set_color(c_white); draw_rectangle(b2x1, b2y1, b2x2, b2y2, false);
        draw_set_color(c_black); draw_rectangle(b2x1 + 3, b2y1 + 3, b2x2 - 3, b2y2 - 3, true);
        draw_set_color(c_white); draw_rectangle(b2x1 + 5, b2y1 + 5, b2x2 - 5, b2y2 - 5, true);
        draw_set_color(c_black);
        if (mouse_check_button_pressed(mb_left)) exibir_popup = false;
    } else {
        draw_set_color(c_black); draw_rectangle(b2x1, b2y1, b2x2, b2y2, false);
        draw_set_color(c_white); draw_rectangle(b2x1 + 3, b2y1 + 3, b2x2 - 3, b2y2 - 3, true);
        draw_set_color(c_black); draw_rectangle(b2x1 + 5, b2y1 + 5, b2x2 - 5, b2y2 - 5, true);
        draw_set_color(c_white);
    }
    draw_set_halign(fa_center); draw_set_valign(fa_middle);
    draw_text((b2x1 + b2x2) / 2, (b2y1 + b2y2) / 2, "NÃO");
}

if (fade_alpha > 0) {
    draw_set_color(c_black);
    draw_set_alpha(fade_alpha);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(1.0);
}