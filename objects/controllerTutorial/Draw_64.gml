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

if (mostrar_round) {
    var alpha = 1;
    if (round_timer > 50) alpha = (60 - round_timer) / 10;
    if (round_timer < 10) alpha = round_timer / 10;
    draw_set_alpha(alpha);
    draw_set_color(c_black);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(gui_w / 2 + 4, gui_h / 2 - 100 + 4, "ROUND " + string(round_atual));
    draw_set_color(c_white);
    draw_text(gui_w / 2, gui_h / 2 - 100, "ROUND " + string(round_atual));
    draw_set_alpha(1);
}

letreiro_x -= letreiro_velocidade;
var texto_w = string_width(texto_guia);
if (letreiro_x < -texto_w) letreiro_x = gui_w;
draw_text(letreiro_x, 20, texto_guia);

if (status_tutorial < 6 && !exibir_popup) {
    var bw = 120, bh = 30, bx1 = gui_w - bw - 20, by1 = 80, bx2 = gui_w - 20, by2 = by1 + bh;
    var m_sobre = (mx >= bx1 && mx <= bx2 && my >= by1 && my <= by2);
    if (m_sobre) {
        draw_set_color(c_white); draw_rectangle(bx1, by1, bx2, by2, false);
        draw_set_color(c_black); draw_rectangle(bx1 + 2, by1 + 2, bx2 - 2, by2 - 2, true);
        draw_set_color(c_black);
        if (mouse_check_button_pressed(mb_left)) exibir_popup = true;
    } else {
        draw_set_color(c_black); draw_rectangle(bx1, by1, bx2, by2, false);
        draw_set_color(c_white); draw_rectangle(bx1 + 2, by1 + 2, bx2 - 2, by2 - 2, true);
        draw_set_color(c_white);
    }
    draw_set_halign(fa_center); draw_set_valign(fa_middle);
    draw_text((bx1 + bx2)/2, (by1 + by2)/2, "SKIP");
}

var hp_x = 40, hp_y = gui_h - 100;

//box hp uhuu

    var hp_w = 300, hp_h = 40;
    draw_set_color(c_black);
    draw_rectangle(hp_x, hp_y, hp_x + hp_w, hp_y + hp_h, false);
    draw_set_color(c_red);
    draw_rectangle(hp_x + 4, hp_y + 4, hp_x + hp_w - 4, hp_y + hp_h - 4, false);
    draw_set_color(c_lime);
    draw_rectangle(hp_x + 4, hp_y + 4, hp_x + 4 + ((hp_w - 10) * (player_hp / player_max_hp)), hp_y + hp_h - 4, false);
    draw_set_color(c_white);
    draw_set_halign(fa_center); draw_set_valign(fa_middle);
    draw_text(hp_x + hp_w/2, hp_y + hp_h/2, "HP: " + string(player_hp));


var sprint_atual = (instance_exists(objPlayer)) ? objPlayer.sprint_atual : 100;
var s_x = hp_x, s_y = hp_y + 50, s_w = 300, s_h = 20;
draw_set_color(c_black);
draw_rectangle(s_x, s_y, s_x + s_w, s_y + s_h, false);
draw_set_color(c_orange);
var sprint_prog = sprint_atual / 100;
draw_rectangle(s_x + 2, s_y + 2, s_x + 2 + ((s_w - 4) * sprint_prog), s_y + s_h - 2, false);
draw_set_color(c_white);
draw_set_halign(fa_left); draw_set_valign(fa_middle);

draw_set_color(c_black);
draw_set_halign(fa_right); draw_set_valign(fa_top);
draw_text(gui_w - 20, 50, "Coins: " + string(moedas));

if (modo_combate) {
    var f_w = 300, f_h = 20, f_x = hp_x, f_y = hp_y - f_h - 6;
    draw_set_color(c_black);
    draw_rectangle(f_x, f_y, f_x + f_w, f_y + f_h, false);
    var progresso = 1 - (cooldown_atual / cooldown_maximo);
    draw_set_color(progresso > 0.7 ? c_lime : c_red);
    draw_rectangle(f_x + 2, f_y + 2, f_x + 2 + ((f_w - 4) * progresso), f_y + f_h - 2, false);
    draw_set_color(c_black);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(global.fonteLM);
    draw_text(f_x + f_w/2, f_y + f_h/2, "ATTACK READY");
}

if (dano_timer > 0) {
    var alpha = min(1, dano_timer / 30);
    var shake_x = (1 - alpha) * 6 * (irandom(1) ? 1 : -1);
    var shake_y = (1 - alpha) * 6 * (irandom(1) ? 1 : -1);
    var escala = 1 + (1 - alpha) * 0.5;
    draw_set_alpha(alpha);
    draw_set_color(alpha > 0.5 ? c_red : c_white);
    draw_set_halign(fa_right);
    draw_set_valign(fa_bottom);
    draw_set_font(global.fonteNormal);
    draw_text_transformed(gui_w - 20 + shake_x, gui_h - 20 + shake_y, "-" + string(dano_mostrar), escala, escala, 0);
    draw_set_alpha(1);
}

if (menu_aberto) menu_y_anim = lerp(menu_y_anim, 60, 0.15);
else menu_y_anim = lerp(menu_y_anim, -gui_h, 0.15);

if (delay_entrada > 0) delay_entrada--;
if (delay_submenu > 0) delay_submenu--;

if (menu_y_anim > -gui_h + 5) {
    var m_x1 = 60, m_y1 = menu_y_anim, m_x2 = gui_w - 60, m_y2 = menu_y_anim + (gui_h - 120);
    draw_set_color(c_black);
    draw_rectangle(m_x1, m_y1, m_x2, m_y2, false);
    draw_set_color(c_white);
    draw_rectangle(m_x1 + 3, m_y1 + 3, m_x2 - 3, m_y2 - 3, true);
    draw_set_color(c_black);
    draw_rectangle(m_x1 + 5, m_y1 + 5, m_x2 - 5, m_y2 - 5, true);

    if (menu_aberto && sub_menu_estado == "normal" && delay_entrada == 0) {
        if (keyboard_check_pressed(ord("X"))) { foco_aba = true; menu_opcao_vertical = 0; slot_inv_selecionado = 0; }
        if (keyboard_check_pressed(ord("Z"))) {
            if (foco_aba) { foco_aba = false; delay_entrada = 30; menu_opcao_vertical = 0; slot_inv_selecionado = 0; }
        }
        if (foco_aba) {
            if (keyboard_check_pressed(vk_right)) aba_selecionada = (aba_selecionada + 1) % 4;
            if (keyboard_check_pressed(vk_left)) aba_selecionada = (aba_selecionada + 3) % 4;
        } else {
            if (aba_selecionada == 0) {
                if (keyboard_check_pressed(vk_down)) menu_opcao_vertical = (menu_opcao_vertical + 1) % 3;
                if (keyboard_check_pressed(vk_up)) menu_opcao_vertical = (menu_opcao_vertical + 2) % 3;
            }
            if (aba_selecionada == 1) {
                if (keyboard_check_pressed(vk_right)) slot_inv_selecionado = (slot_inv_selecionado + 1) % 10;
                if (keyboard_check_pressed(vk_left)) slot_inv_selecionado = (slot_inv_selecionado + 9) % 10;
            }
            if (aba_selecionada == 2) {
                if (keyboard_check_pressed(vk_down)) menu_opcao_vertical = (menu_opcao_vertical + 1) % 3;
                if (keyboard_check_pressed(vk_up)) menu_opcao_vertical = (menu_opcao_vertical + 2) % 3;
            }
        }
    }

    var abas = ["GAME", "INVENTORY", "SETTINGS", "CONTROLS"];
    for (var a = 0; a < 4; a++) {
        var ax = m_x1 + 50 + (a * 180), ay = m_y1 + 40;
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
            var opcoes = ["SAVE GAME", "LOAD GAME", "EXIT GAME"];
            if (menu_aberto && !foco_aba && delay_entrada == 0) {
                if (keyboard_check_pressed(ord("Z"))) {
                    if (menu_opcao_vertical == 0) { sub_menu_estado = "save_slots"; menu_save_tipo = "salvar"; slot_selecionado = 0; }
                    if (menu_opcao_vertical == 1) { sub_menu_estado = "save_slots"; menu_save_tipo = "carregar"; slot_selecionado = 0; }
                    if (menu_opcao_vertical == 2) { room_goto(rm_menu); }
                }
            }
            for (var o = 0; o < 3; o++) {
                if (o == menu_opcao_vertical && !foco_aba) draw_set_color(c_yellow);
                else draw_set_color(c_white);
                draw_text(m_x1 + 50, content_y + (o * 50), opcoes[o]);
            }
        } else if (sub_menu_estado == "save_slots") {
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
                        ini_write_real("Progress", "Moedas", moedas);
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
                        moedas = ini_read_real("Progress", "Moedas", 0);
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
                    var moedas_salvo = ini_read_real("Progress", "Moedas", 0);
                    ini_close();
                    slot_text += "HP: " + string(hp_salvo) + " | 🪙 " + string(moedas_salvo);
                } else slot_text += "Empty";
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
        var slot_size = 70, start_sx = m_x1 + 30;
        if (sub_menu_estado == "normal" && menu_aberto && !foco_aba && delay_entrada == 0) {
            if (keyboard_check_pressed(ord("Z")) && slot_inv_selecionado < itens_coletados) {
                sub_menu_estado = "inv_action";
                item_sub_opcao = 0;
                delay_submenu = 30;
            }
        }
        for (var i = 0; i < 10; i++) {
            var sx1 = start_sx + (i % 5) * 90, sy1 = content_y + floor(i/5) * 100;
            var sx2 = sx1 + slot_size, sy2 = sy1 + slot_size;
            if (i == slot_inv_selecionado && !foco_aba && sub_menu_estado == "normal") draw_set_color(c_yellow);
            else draw_set_color(c_white);
            draw_rectangle(sx1, sy1, sx2, sy2, true);
            if (i < itens_coletados) {
                draw_sprite_ext(spr_item_esfera, 0, (sx1+sx2)/2, (sy1+sy2)/2, 1, 1, 0, c_white, 1);
            }
        }
        if (sub_menu_estado == "inv_action") {
            var p_w = 300, p_h = 200, px1 = (gui_w/2)-p_w/2, py1 = (gui_h/2)-p_h/2, px2 = px1+p_w, py2 = py1+p_h;
            draw_set_color(c_black); draw_rectangle(px1, py1, px2, py2, false);
            draw_set_color(c_white); draw_rectangle(px1+3, py1+3, px2-3, py2-3, true);
            draw_set_color(c_black); draw_rectangle(px1+5, py1+5, px2-5, py2-5, true);
            if (menu_aberto && delay_submenu == 0) {
                if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(vk_up)) item_sub_opcao = (item_sub_opcao + 1) % 3;
                if (keyboard_check_pressed(ord("Z"))) {
                    if (item_sub_opcao == 0) {
                        if (UsarItemCoke()) {
                            itens_coletados--;
                        }
                    }
                    if (item_sub_opcao == 1) {
                        itens_coletados--;
                        if (instance_exists(objPlayer)) {
                            var drop = instance_create_layer(objPlayer.x + 40, objPlayer.y, "Instances", objItemTutorial);
                            drop.coletavel = true;
                            drop.sprite_index = spr_item_esfera;
                            drop.nome = "Coke";
                            drop.tipo = "cura_sprint";
                            drop.valor = 50;
                        }
                    }
                    sub_menu_estado = "normal";
                    delay_submenu = 0;
                }
            }
            draw_set_color(c_white); draw_set_halign(fa_center);
            draw_text(gui_w/2, py1+30, "ITEM ACTION");
            var opcoes = ["USE", "DROP", "CANCEL"];
            for (var o = 0; o < 3; o++) {
                if (o == item_sub_opcao) draw_set_color(c_yellow);
                else draw_set_color(c_white);
                draw_text(gui_w/2, py1+80 + o*35, opcoes[o]);
            }
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
            }
        }
        var txt_fs = "FULLSCREEN: " + (fullscreen ? "ON" : "OFF");
        var txt_au = "AUDIO: " + string(round(audio_volume * 100)) + "%";
        var opcoes = [txt_fs, txt_au];
        for (var c = 0; c < 2; c++) {
            if (c == menu_opcao_vertical && !foco_aba) draw_set_color(c_yellow);
            else draw_set_color(c_white);
            draw_text(m_x1 + 50, content_y + (c * 50), opcoes[c]);
        }
    }

    if (aba_selecionada == 3) {
        draw_set_font(global.fonteNormal);
        draw_set_color(c_white);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        var controles = [
            "ARROWS - Move",
            "SHIFT - Sprint",
            "Z - Interact / Buy",
            "X - Push / Attack",
            "SPACE - Combat Mode",
            "C - Menu"
        ];
        var espacamento = 40;
        var start_x = m_x1 + 80;
        var start_y = content_y;
        for (var i = 0; i < 6; i++) {
            draw_text(start_x, start_y + i * espacamento, controles[i]);
        }
    }
}

if (exibir_popup) {
    var pw = 420, ph = 200, px1 = (gui_w/2)-pw/2, py1 = (gui_h/2)-ph/2, px2 = px1+pw, py2 = py1+ph;
    draw_set_color(c_black); draw_rectangle(px1, py1, px2, py2, false);
    draw_set_color(c_white); draw_rectangle(px1+3, py1+3, px2-3, py2-3, true);
    draw_set_color(c_black); draw_rectangle(px1+5, py1+5, px2-5, py2-5, true);
    draw_set_color(c_white); draw_set_halign(fa_center); draw_set_valign(fa_top);
    draw_text_ext(gui_w/2, py1+25, "Skip tutorial?", 24, 380);
    var b1x1 = px1+40, b1y1 = py2-60, b1x2 = px1+160, b1y2 = py2-20;
    var m1 = (mx >= b1x1 && mx <= b1x2 && my >= b1y1 && my <= b1y2);
    if (m1) { draw_set_color(c_white); draw_rectangle(b1x1,b1y1,b1x2,b1y2,false); draw_set_color(c_black); draw_rectangle(b1x1+3,b1y1+3,b1x2-3,b1y2-3,true); draw_set_color(c_white); draw_rectangle(b1x1+5,b1y1+5,b1x2-5,b1y2-5,true); draw_set_color(c_black); if (mouse_check_button_pressed(mb_left)) { exibir_popup=false; status_tutorial=5; fade_estado="fade_out"; room_goto(rm_menu); } }
    else { draw_set_color(c_black); draw_rectangle(b1x1,b1y1,b1x2,b1y2,false); draw_set_color(c_white); draw_rectangle(b1x1+3,b1y1+3,b1x2-3,b1y2-3,true); draw_set_color(c_black); draw_rectangle(b1x1+5,b1y1+5,b1x2-5,b1y2-5,true); draw_set_color(c_white); }
    draw_set_halign(fa_center); draw_set_valign(fa_middle); draw_text((b1x1+b1x2)/2,(b1y1+b1y2)/2,"YES");
    var b2x1 = px2-160, b2y1 = py2-60, b2x2 = px2-40, b2y2 = py2-20;
    var m2 = (mx >= b2x1 && mx <= b2x2 && my >= b2y1 && my <= b2y2);
    if (m2) { draw_set_color(c_white); draw_rectangle(b2x1,b2y1,b2x2,b2y2,false); draw_set_color(c_black); draw_rectangle(b2x1+3,b2y1+3,b2x2-3,b2y2-3,true); draw_set_color(c_white); draw_rectangle(b2x1+5,b2y1+5,b2x2-5,b2y2-5,true); draw_set_color(c_black); if (mouse_check_button_pressed(mb_left)) exibir_popup = false; }
    else { draw_set_color(c_black); draw_rectangle(b2x1,b2y1,b2x2,b2y2,false); draw_set_color(c_white); draw_rectangle(b2x1+3,b2y1+3,b2x2-3,b2y2-3,true); draw_set_color(c_black); draw_rectangle(b2x1+5,b2y1+5,b2x2-5,b2y2-5,true); draw_set_color(c_white); }
    draw_set_halign(fa_center); draw_set_valign(fa_middle); draw_text((b2x1+b2x2)/2,(b2y1+b2y2)/2,"NO");
}

if (loja_aberta && loja_npc != noone) {
    var lw = 360, lh = 220;
    var lx = (gui_w - lw) / 2, ly = (gui_h - lh) / 2;
    
    draw_set_alpha(loja_alpha);
    
    draw_set_color(c_black);
    draw_rectangle(lx, ly, lx + lw, ly + lh, false);
    draw_set_color(c_white);
    draw_rectangle(lx + 3, ly + 3, lx + lw - 3, ly + lh - 3, true);
    draw_set_color(c_black);
    draw_rectangle(lx + 6, ly + 6, lx + lw - 6, ly + lh - 6, true);
    
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_font(global.fonteNormal);
    draw_text(lx + lw/2, ly + 12, "SHOP");
    
    var item_start_y = ly + 80;
    var slot_w = 150, slot_h = 50;
    var gap = 15;
    var total_w = slot_w * 2 + gap;
    var start_x = lx + (lw - total_w) / 2;
    
    for (var i = 0; i < array_length(loja_itens); i++) {
        var col = i % 2;
        var row = floor(i / 2);
        var sx = start_x + col * (slot_w + gap);
        var sy = item_start_y + row * (slot_h + gap);
        if (i == loja_selecao) {
            draw_set_color(c_yellow);
            draw_rectangle(sx - 2, sy - 2, sx + slot_w + 2, sy + slot_h + 2, false);
        }
        draw_set_color(c_white);
        draw_rectangle(sx, sy, sx + slot_w, sy + slot_h, true);
        draw_set_color(c_black);
        draw_rectangle(sx + 2, sy + 2, sx + slot_w - 2, sy + slot_h - 2, true);
        
        draw_sprite_ext(loja_sprites[i], 0, sx + 28, sy + slot_h/2, 0.6, 0.6, 0, c_white, 1);
        draw_set_color(c_black);
        draw_set_halign(fa_left);
        draw_set_valign(fa_middle);
        draw_set_font(global.fonteLegenda);
        draw_text(sx + 45, sy + 20, loja_nomes[i]);
        draw_set_color(c_yellow);
        draw_set_valign(fa_bottom);
        draw_text(sx + 45, sy + slot_h - 6, string(loja_precos[i]) + "🪙");
    }
    
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_set_font(global.fonteLegenda);
    draw_text(lx + lw/2, ly + lh - 12, "ARROWS - Select   Z - Buy   X - Close");
    
    draw_set_alpha(1);
}

if (fade_alpha > 0) {
    draw_set_color(c_black);
    draw_set_alpha(fade_alpha);
    draw_rectangle(0, 0, gui_w, gui_h, false);
    draw_set_alpha(1.0);
}