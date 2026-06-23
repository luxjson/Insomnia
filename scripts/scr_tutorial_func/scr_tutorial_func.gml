function ResetScene(stepNumber) {
    if (instance_exists(objNpcTutorial)) instance_destroy(objNpcTutorial);
    if (instance_exists(objCaixaTutorial)) instance_destroy(objCaixaTutorial);
    if (instance_exists(objItemTutorial)) instance_destroy(objItemTutorial);
    if (instance_exists(objInimigoTutorial)) instance_destroy(objInimigoTutorial);
    if (instance_exists(objLinhaChegada)) instance_destroy(objLinhaChegada);
    if (instance_exists(objMarcadorCaixa)) instance_destroy(objMarcadorCaixa);

    if (instance_exists(objPlayer)) {
        objPlayer.x = room_width / 2;
        objPlayer.y = room_height / 2;
        objPlayer.velocidade = 5;
        objPlayer.sprint_atual = 100;
        objPlayer.dano_timer_player = 0;
    }

    var controle = instance_find(controllerTutorial, 0);
    if (controle != noone) {
        controle.status_tutorial = stepNumber;
        controle.npcs_falados = 0;
        controle.itens_coletados = 0;
        controle.itens_removidos_count = 0;
        controle.inimigos_derrotados = 0;
        controle.dano_aplicado = 0;
        controle.caixas_encaixadas = 0;
        controle.round_atual = 0;
        controle.moedas = 100;
        controle.comerciantes_falados = 0;
        controle.total_comerciantes = 5;

        var cx = room_width / 2;
        var cy = room_height / 2;
        var camada = (instance_exists(objPlayer)) ? objPlayer.layer : "Instances";

        switch(stepNumber) {
            case 1:
                controle.texto_guia = "Talk to 5 merchants and buy a Coke from each (10 coins each).";
                for (var i = 0; i < 5; i++) {
                    var nx, ny, tentativas = 0;
                    var valido = false;
                    while (!valido && tentativas < 50) {
                        nx = random_range(80, room_width - 80);
                        ny = random_range(80, room_height - 80);
                        tentativas++;
                        if (instance_exists(objPlayer)) {
                            if (point_distance(nx, ny, objPlayer.x, objPlayer.y) > 100) {
                                valido = true;
                            }
                        } else {
                            valido = true;
                        }
                    }
                    var npc = instance_create_layer(nx, ny, camada, objNpcTutorial);
                    npc.tipo = "comerciante";
                    npc.mercadoria = "Coke";
                    npc.preco = 10;
                    npc.vendido = false;
                }
                break;

            case 2:
			    controle.texto_guia = "Push the 3 boxes onto the marked spots! (Press X)";
			    var posicoes = [
			        [room_width * 0.15, room_height * 0.15],
			        [room_width * 0.85, room_height * 0.15],
			        [room_width * 0.5, room_height * 0.85]
			    ];
			    for (var i = 0; i < 3; i++) {
			        var bx = random_range(100, room_width - 100);
			        var by = random_range(100, room_height - 100);
			        var box = instance_create_layer(bx, by, camada, objCaixaTutorial);
			        box.id_caixa = i;
			        box.travada = false;
			        var m = instance_create_layer(posicoes[i][0], posicoes[i][1], camada, objMarcadorCaixa);
			        m.id_caixa = i;
			    }
			    break;

            case 3:
                controle.texto_guia = "Race against the NPC to the finish line! Hold SHIFT to sprint.";
                var npc = instance_create_layer(cx - 300, cy, camada, objNpcTutorial);
                npc.tipo = "corredor";
                npc.velocidade_corrida = 8;
                instance_create_layer(cx + 400, cy - 100, camada, objLinhaChegada);
                instance_create_layer(cx + 400, cy + 100, camada, objLinhaChegada);
                break;

            case 4:
                controle.texto_guia = "Fight 10 rounds of enemies! Round 1 starts now.";
                controle.round_atual = 1;
                SpawnEnemies(controle.round_atual);
                break;

            case 5:
                controle.texto_guia = "CONGRATULATIONS! You completed the INSOMNIA tutorial!";
                var medalha = instance_create_layer(cx, cy - 150, camada, objItemTutorial);
                medalha.coletavel = true;
                if (sprite_exists(spr_medalha)) medalha.sprite_index = spr_medalha;
                break;
        }
    }
}

function SpawnEnemies(round) {
    var controle = instance_find(controllerTutorial, 0);
    if (controle == noone) return;
    var count = min(round, 5);
    var vida_base = 40;
    var hp = vida_base * (1 + (round - 1) * 0.25);
    for (var i = 0; i < count; i++) {
        var ang = i * (360 / count);
        var dist = 150 + random(100);
        var pos_x = room_width / 2 + lengthdir_x(dist, ang);
        var pos_y = room_height / 2 + lengthdir_y(dist, ang);
        var inim = instance_create_layer(pos_x, pos_y, "Instances", objInimigoTutorial);
        inim.vida = hp;
        inim.rodada = round;
    }
}

function ComprarCoke(npc) {
    var controle = instance_find(controllerTutorial, 0);
    if (controle == noone) return false;
    if (npc.vendido) return false;
    if (controle.moedas < npc.preco) {
        controle.texto_guia = "Not enough coins! Need " + string(npc.preco) + "🪙";
        if (controle.alarm[1] == -1) controle.alarm[1] = 60;
        return false;
    }
    controle.moedas -= npc.preco;
    npc.vendido = true;
    controle.comerciantes_falados++;
    var item = instance_create_layer(npc.x, npc.y + 20, "Instances", objItemTutorial);
    item.sprite_index = spr_item_esfera;
    item.coletavel = true;
    item.nome = "Coke";
    item.tipo = "cura_sprint";
    item.valor = 50;
    if (controle.comerciantes_falados >= controle.total_comerciantes) {
        controle.fade_estado = "fade_out";
    }
    return true;
}

function UsarItemCoke() {
    var controle = instance_find(controllerTutorial, 0);
    if (controle == noone) return false;
    if (instance_exists(objPlayer)) {
        objPlayer.sprint_atual = min(100, objPlayer.sprint_atual + 50);
        controle.texto_guia = "Sprint restored! +50 SPRINT";
        if (controle.alarm[1] == -1) controle.alarm[1] = 60;
        return true;
    }
    return false;
}

function VerificarCaixas() {
    var controle = instance_find(controllerTutorial, 0);
    if (controle == noone) return;
    var todas_encaixadas = true;
    with (objCaixaTutorial) {
        if (!travada) todas_encaixadas = false;
    }
    if (todas_encaixadas && instance_exists(objCaixaTutorial)) {
        controle.fade_estado = "fade_out";
    }
}

function AbrirLoja(npc) {
    var controle = instance_find(controllerTutorial, 0);
    if (controle == noone) return;
    if (npc.vendido) return;
    controle.loja_aberta = true;
    controle.loja_npc = npc;
    controle.loja_selecao = 0;
    controle.loja_itens = ["Coke"];
    controle.loja_precos = [10];
    controle.loja_nomes = ["Coke"];
    controle.loja_sprites = [spr_item_esfera];
    controle.loja_alpha = 0;
    controle.loja_scale = 0.5;
}

function FecharLoja() {
    var controle = instance_find(controllerTutorial, 0);
    if (controle == noone) return;
    controle.loja_aberta = false;
    controle.loja_npc = noone;
    controle.loja_alpha = 0;
    controle.loja_scale = 0.5;
}

function ComprarItemLoja() {
    var controle = instance_find(controllerTutorial, 0);
    if (controle == noone) return false;
    if (controle.loja_npc == noone) return false;
    if (controle.loja_npc.vendido) return false;
    var idx = controle.loja_selecao;
    if (idx >= array_length(controle.loja_itens)) return false;
    var preco = controle.loja_precos[idx];
    if (controle.moedas < preco) {
        controle.texto_guia = "Not enough coins! Need " + string(preco) + "🪙";
        if (controle.alarm[1] == -1) controle.alarm[1] = 60;
        return false;
    }
    controle.moedas -= preco;
    if (controle.itens_coletados < 10) {
        controle.itens_coletados++;
    }
    controle.loja_npc.vendido = true;
    controle.comerciantes_falados++;
    FecharLoja();
    if (controle.comerciantes_falados >= controle.total_comerciantes) {
        controle.fade_estado = "fade_out";
    }
    return true;
}