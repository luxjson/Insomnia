if (morto) {
    sprite_index = spr_player_death;
    var frame_final_death = death_frame_inicial + 7;
    if (image_index < death_frame_inicial || image_index > frame_final_death) {
        image_index = frame_final_death;
        image_speed = 0;
    }
    exit;
}

if (dash_cooldown > 0) dash_cooldown--;

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

if (estado == "dash") {
    x += lengthdir_x(dash_velocidade, dir_dash_atual);
    y += lengthdir_y(dash_velocidade, dir_dash_atual);
    
    sprite_index = spr_player_dash;
    
    dash_timer--;
    if (dash_timer <= 0) {
        estado = "normal";
        dash_cooldown = 20;
    }
} else if (estado == "normal") {
    if (keyboard_check_pressed(vk_lshift) && dash_cooldown <= 0) {
        estado = "dash";
        dash_timer = dash_duracao;
        if (h_input != 0 || v_input != 0) {
            dir_dash_atual = point_direction(0, 0, h_input, v_input);
        } else {
            switch (olhando_para) {
                case "right":      dir_dash_atual = 0; break;
                case "right_up":   dir_dash_atual = 45; break;
                case "up":         dir_dash_atual = 90; break;
                case "left_up":    dir_dash_atual = 135; break;
                case "left":       dir_dash_atual = 180; break;
                case "left_down":  dir_dash_atual = 225; break;
                case "down":       dir_dash_atual = 270; break;
                case "right_down": dir_dash_atual = 315; break;
            }
        }
    }

    if (estado == "normal" && (h_input != 0 || v_input != 0)) {
        var direcao = point_direction(0, 0, h_input, v_input);
        x += lengthdir_x(velocidade, direcao);
        y += lengthdir_y(velocidade, direcao);
        
        if (direcao >= 337.5 || direcao < 22.5)       olhando_para = "right";
        else if (direcao >= 22.5 && direcao < 67.5)   olhando_para = "right_up";
        else if (direcao >= 67.5 && direcao < 112.5)  olhando_para = "up";
        else if (direcao >= 112.5 && direcao < 157.5) olhando_para = "left_up";
        else if (direcao >= 157.5 && direcao < 202.5) olhando_para = "left";
        else if (direcao >= 202.5 && direcao < 247.5) olhando_para = "left_down";
        else if (direcao >= 247.5 && direcao < 292.5) olhando_para = "down";
        else if (direcao >= 292.5 && direcao < 337.5) olhando_para = "right_down";
        
        sprite_index = spr_player;
    } else if (estado == "normal") {
        sprite_index = spr_player_idle;
    }
}

if (sprite_index == spr_player_idle) {
    if (olhando_para == "down")       frame_inicial = 0;
    if (olhando_para == "left")       frame_inicial = 8;
    if (olhando_para == "left_up")    frame_inicial = 16;
    if (olhando_para == "up")         frame_inicial = 24;
    if (olhando_para == "right_up")   frame_inicial = 32;
    if (olhando_para == "right")      frame_inicial = 40;
    if (olhando_para == "left_down")  frame_inicial = 0; 
    if (olhando_para == "right_down") frame_inicial = 0; 
} else {
    if (olhando_para == "down")       frame_inicial = 0;
    if (olhando_para == "left")       frame_inicial = 8;
    if (olhando_para == "left_up")    frame_inicial = 16;
    if (olhando_para == "up")         frame_inicial = 24;
    if (olhando_para == "right_up")   frame_inicial = 32;
    if (olhando_para == "right")      frame_inicial = 40;
    if (olhando_para == "left_down")  frame_inicial = 0; 
    if (olhando_para == "right_down") frame_inicial = 0; 
}

var frame_final = frame_inicial + 7;

if (image_index < frame_inicial || image_index > frame_final) {
    image_index = frame_inicial;
}

var _meio_w = sprite_width/2, _meio_h = sprite_height/2;
x = clamp(x, _meio_w, room_width - _meio_w);
y = clamp(y, _meio_h, room_height - _meio_h);

if (place_meeting(x, y, objCaixaTutorial)) { x = xprevious; y = yprevious; }
if (place_meeting(x, y, objInimigoTutorial)) { x = xprevious; y = yprevious; }
if (place_meeting(x, y, objNpcTutorial)) { x = xprevious; y = yprevious; }

if (controle != noone) {
    if (keyboard_check(vk_lshift) && sprint_atual > 0 && estado == "normal") {
        velocidade = dash_velocidade;
        sprint_atual -= 0.5;
        if (sprint_atual < 0) sprint_atual = 0;
    } else {
        if (sprint_atual < 100) sprint_atual += 0.2;
        if (!keyboard_check(vk_lshift)) velocidade = velocidade;
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
                        case "right":      dir_empurrar = 0; break;
                        case "right_up":   dir_empurrar = 45; break;
                        case "up":         dir_empurrar = 90; break;
                        case "left_up":    dir_empurrar = 135; break;
                        case "left":       dir_empurrar = 180; break;
                        case "left_down":  dir_empurrar = 225; break;
                        case "down":       dir_empurrar = 270; break;
                        case "right_down": dir_empurrar = 315; break;
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
