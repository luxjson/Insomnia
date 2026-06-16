var h_input = keyboard_check(vk_right) - keyboard_check(vk_left);
var v_input = keyboard_check(vk_down) - keyboard_check(vk_up);
var controle = instance_find(controllerTutorial, 0);

if (controle != noone) {
    if (keyboard_check_pressed(ord("C"))) {
        controle.menu_aberto = !controle.menu_aberto;
        if (controle.menu_aberto) {
            controle.foco_aba = true;
            controle.menu_opcao_vertical = 0;
            controle.slot_inv_selecionado = 0;
        }
    }
}

if (controle == noone || controle.menu_aberto) {
    exit;
}

if (h_input != 0 || v_input != 0) {
    var direcao = point_direction(0, 0, h_input, v_input);
    x += lengthdir_x(velocidade, direcao);
    y += lengthdir_y(velocidade, direcao);
    if (v_input < 0) olhando_para = "up";
    else if (v_input > 0) olhando_para = "down";
    else if (h_input > 0) olhando_para = "right";
    else if (h_input < 0) olhando_para = "left";
}

var _meio_w = sprite_width / 2;
var _meio_h = sprite_height / 2;
x = clamp(x, _meio_w, room_width - _meio_w);
y = clamp(y, _meio_h, room_height - _meio_h);

var nova_sprite = sprite_index;
if (olhando_para == "up")    nova_sprite = spr_player_back;
if (olhando_para == "down")  nova_sprite = spr_player;
if (olhando_para == "right") nova_sprite = spr_player_right;
if (olhando_para == "left")  nova_sprite = spr_player_left;

if (sprite_index != nova_sprite) {
    sprite_index = nova_sprite;
    image_index = 0;
}
if (h_input == 0 && v_input == 0) {
    image_index = 0;
}

if (controle != noone) {
    if (keyboard_check(vk_lshift) && (controle.status_tutorial == 2 || controle.status_tutorial == 5)) {
        velocidade = 12;
    } else {
        velocidade = 5;
    }
    
    if (keyboard_check_pressed(vk_space)) {
        controle.modo_combate = !controle.modo_combate;
    }
    
    for (var i = 1; i <= 5; i++) {
        if (keyboard_check_pressed(ord(string(i)))) {
            if (controle.itens_coletados >= i) {
                if (item_equipado == i) item_equipado = -1;
                else item_equipado = i;
            }
        }
    }
    
    if (controle.modo_combate) {
        if (controle.barra_subindo) {
            controle.forca_barra += controle.barra_velocidade;
            if (controle.forca_barra >= 1) { controle.forca_barra = 1; controle.barra_subindo = false; }
        } else {
            controle.forca_barra -= controle.barra_velocidade;
            if (controle.forca_barra <= 0) { controle.forca_barra = 0; controle.barra_subindo = true; }
        }
    }
    
    if (controle.texto_combo_alpha > 0) {
        controle.texto_combo_alpha -= 0.02;
    }
    
    controle.zoom_atual = lerp(controle.zoom_atual, controle.zoom_alvo, 0.1);
    if (controle.zoom_atual <= controle.zoom_alvo + 0.01) {
        controle.zoom_alvo = 1.0;
    }
    camera_set_view_size(view_camera, 1920 * controle.zoom_atual, 1080 * controle.zoom_atual);
    
    if (keyboard_check_pressed(ord("X"))) {
        if (controle.modo_combate) {
            if (controle.forca_barra >= 0.75 && controle.forca_barra <= 0.95) {
                controle.combo_atual++;
                controle.texto_combo_alpha = 1.5;
                if (controle.combo_atual == 1) {
                    controle.texto_combo = "COMBO!";
                    controle.dano_aplicado = 10;
                    controle.zoom_alvo = 0.95;
                } else if (controle.combo_atual == 2) {
                    controle.texto_combo = "COMBO 2X!";
                    controle.dano_aplicado = 15;
                    controle.zoom_alvo = 0.90;
                } else {
                    controle.texto_combo = "SUPER COMBO!!!";
                    controle.dano_aplicado = 30;
                    controle.zoom_alvo = 0.82;
                }
                
                var inimigo = instance_nearest(x, y, objInimigoTutorial);
                if (inimigo != noone && distance_to_object(inimigo) < 60) {
                    with (inimigo) {
                        vida -= controle.dano_aplicado;
                        if (vida <= 0) {
                            instance_destroy();
                        }
                    }
                }
            } else {
                controle.combo_atual = 0;
                controle.texto_combo = "ERROU!";
                controle.texto_combo_alpha = 1.0;
                controle.dano_aplicado = 0;
            }
        } else {
            var idx_bloco = asset_get_index("objCaixaTutorial");
            if (idx_bloco != -1) {
                var bloco = instance_nearest(x, y, idx_bloco);
                if (bloco != noone && distance_to_object(bloco) < 10 && !bloco.travada) {
                    var dir_empurrar = 0;
                    if (olhando_para == "right") dir_empurrar = 0;
                    if (olhando_para == "up")    dir_empurrar = 90;
                    if (olhando_para == "left")  dir_empurrar = 180;
                    if (olhando_para == "down")  dir_empurrar = 270;
                    var distancia = 20;
                    
                    with(bloco) {
                        x += lengthdir_x(distancia, dir_empurrar);
                        y += lengthdir_y(distancia, dir_empurrar);
                        if (x >= room_width / 2 + 200) {
                            travada = true;
                            x = room_width / 2 + 250;
                            show_debug_message("Caixa encaixada com sucesso!");
                        }
                    }
                }
            }
        }
    }
    
    if (keyboard_check_pressed(ord("Z"))) {
        var idx_item = asset_get_index("objItemTutorial");
        if (idx_item != -1) {
            var item = instance_nearest(x, y, idx_item);
            if (item != noone && distance_to_object(item) < 40 && item.coletavel) {
                if (controle.itens_coletados < 5) {
                    controle.itens_coletados++;
                    instance_destroy(item);
                }
            }
        }
        
        var idx_npc = asset_get_index("objNpcTutorial");
        if (idx_npc != -1) {
            var npc = instance_nearest(x, y, idx_npc);
            if (npc != noone && distance_to_object(npc) < 40) {
                with (npc) {
                    if (!ja_falou) {
                        ja_falou = true;
                        controle.npcs_falados++;
                        if (controle.status_tutorial == 1 && controle.npcs_falados >= controle.total_npcs_p1) {
                            controle.fade_estado = "fade_out";
                        }
                    }
                }
            }
        }
    }
}