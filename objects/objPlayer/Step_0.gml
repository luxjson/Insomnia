var h_input = keyboard_check(vk_right) - keyboard_check(vk_left);
var v_input = keyboard_check(vk_down) - keyboard_check(vk_up);
controle = instance_find(controllerTutorial, 0);

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

var _meio_w = sprite_width/2, _meio_h = sprite_height/2;
x = clamp(x, _meio_w, room_width - _meio_w);
y = clamp(y, _meio_h, room_height - _meio_h);

if (place_meeting(x, y, objCaixaTutorial)) { x = xprevious; y = yprevious; }
if (place_meeting(x, y, objInimigoTutorial)) { x = xprevious; y = yprevious; }
if (place_meeting(x, y, objNpcTutorial)) { x = xprevious; y = yprevious; }

var nova_sprite = sprite_index;
if (olhando_para == "up") nova_sprite = spr_player_back;
if (olhando_para == "down") nova_sprite = spr_player;
if (olhando_para == "right") nova_sprite = spr_player_right;
if (olhando_para == "left") nova_sprite = spr_player_left;
if (sprite_index != nova_sprite) { sprite_index = nova_sprite; image_index = 0; }
if (h_input == 0 && v_input == 0) image_index = 0;

if (controle != noone) {
    if (keyboard_check(vk_lshift) && sprint_atual > 0) {
        velocidade = 12;
        sprint_atual -= 0.5;
        if (sprint_atual < 0) sprint_atual = 0;
    } else {
        if (sprint_atual < 100) sprint_atual += 0.2;
        if (!keyboard_check(vk_lshift)) velocidade = 5;
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

    if (controle.cooldown_atual > 0) controle.cooldown_atual--;
    controle.zoom_ataque_atual = lerp(controle.zoom_ataque_atual, controle.zoom_ataque_alvo, 0.1);
    if (controle.zoom_ataque_atual <= controle.zoom_ataque_alvo + 0.01) controle.zoom_ataque_alvo = 1.0;
    camera_set_view_size(view_camera, 1920 * controle.zoom_ataque_atual, 1080 * controle.zoom_ataque_atual);
    if (controle.dano_timer > 0) controle.dano_timer--;

    if (dano_timer_player > 0) {
        image_blend = c_red;
        dano_timer_player--;
    } else {
        image_blend = c_white;
    }

    if (keyboard_check_pressed(ord("X"))) {
        if (controle.loja_aberta) {
            FecharLoja();
        } else if (controle.modo_combate) {
            if (controle.cooldown_atual <= 0) {
                controle.dano_aplicado = 15;
                controle.cooldown_atual = controle.cooldown_maximo;
                controle.dano_mostrar = controle.dano_aplicado;
                controle.dano_timer = 30;
                controle.zoom_ataque_alvo = 0.90;

                var inimigo = instance_nearest(x, y, objInimigoTutorial);
                if (inimigo != noone && distance_to_object(inimigo) < 60) {
                    with (inimigo) {
                        vida -= other.controle.dano_aplicado;
                        dano_timer = 10;
                        if (vida <= 0) {
                            instance_destroy();
                            var ctrl = other.controle;
                            ctrl.inimigos_derrotados++;
                        }
                    }
                }
            }
        } else {
            var idx_bloco = asset_get_index("objCaixaTutorial");
            if (idx_bloco != -1) {
                var bloco = instance_nearest(x, y, idx_bloco);
                if (bloco != noone && distance_to_object(bloco) < 40 && !bloco.travada) {
                    var dir_empurrar = 0;
                    switch (olhando_para) {
                        case "right": dir_empurrar = 0; break;
                        case "up":    dir_empurrar = 90; break;
                        case "left":  dir_empurrar = 180; break;
                        case "down":  dir_empurrar = 270; break;
                    }
                    var passo = 20;
                    with (bloco) {
                        x += lengthdir_x(passo, dir_empurrar);
                        y += lengthdir_y(passo, dir_empurrar);
                        x = clamp(x, 0, room_width);
                        y = clamp(y, 0, room_height);
                        var marcador = noone;
                        with (objMarcadorCaixa) {
                            if (id_caixa == other.id_caixa && distance_to_object(other) < 5) {
                                marcador = id;
                                break;
                            }
                        }
                        if (marcador != noone) {
                            travada = true;
                            x = marcador.x;
                            y = marcador.y;
                            var ctrl = instance_find(controllerTutorial, 0);
                            if (ctrl != noone) {
                                ctrl.caixas_encaixadas++;
                                if (ctrl.caixas_encaixadas >= 3) {
                                    ctrl.fade_estado = "fade_out";
                                }
                            }
                            instance_destroy(marcador);
                        }
                    }
                }
            }
        }
    }

    if (keyboard_check_pressed(ord("Z"))) {
        if (controle.loja_aberta) {
            if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(vk_right)) {
                controle.loja_selecao = (controle.loja_selecao + 1) % array_length(controle.loja_itens);
            }
            if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_left)) {
                controle.loja_selecao = (controle.loja_selecao - 1 + array_length(controle.loja_itens)) % array_length(controle.loja_itens);
            }
            if (keyboard_check_pressed(ord("Z"))) {
                ComprarItemLoja();
            }
        } else {
            var npc = instance_nearest(x, y, objNpcTutorial);
            if (npc != noone && distance_to_object(npc) < 40) {
                if (npc.tipo == "comerciante" && !npc.vendido) {
                    AbrirLoja(npc);
                } else if (npc.tipo == "normal" && !npc.ja_falou) {
                    with (npc) {
                        ja_falou = true;
                        other.controle.npcs_falados++;
                        if (other.controle.npcs_falados >= other.controle.total_npcs_p1) {
                            other.controle.fade_estado = "fade_out";
                        }
                    }
                }
            }
            var idx_item = asset_get_index("objItemTutorial");
            if (idx_item != -1) {
                var item = instance_nearest(x, y, idx_item);
                if (item != noone && distance_to_object(item) < 40 && item.coletavel) {
                    if (controle.itens_coletados < 10) {
                        controle.itens_coletados++;
                        instance_destroy(item);
                    }
                }
            }
        }
    }

    if (controle.status_tutorial == 3 && instance_exists(objLinhaChegada)) {
        var linha = instance_find(objLinhaChegada, 0);
        if (linha != noone && x >= linha.x) {
            controle.fade_estado = "fade_out";
        }
    }
}