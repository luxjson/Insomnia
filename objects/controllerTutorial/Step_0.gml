if (fade_estado == "fade_out") {
    if (fade_alpha < 1) fade_alpha += 0.04;
    else fade_estado = "switch";
} else if (fade_estado == "fade_in") {
    if (fade_alpha > 0) fade_alpha -= 0.04;
}

if (fade_estado == "switch") {
    if (status_tutorial == 1) {
        ResetScene(2);
    } else if (status_tutorial == 2) {
        ResetScene(3);
    } else if (status_tutorial == 3) {
        ResetScene(4);
    } else if (status_tutorial == 4) {
        ResetScene(5);
    } else {
        ResetScene(status_tutorial + 1);
    }
    janela_missao_aberta = true;
    fade_estado = "fade_in";
}

if (janela_missao_aberta) {
    if (fade_alpha < 0.5) {
        if (keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(ord("X"))) {
            janela_missao_aberta = false;
        }
    }
    exit;
}

if (status_tutorial == 5 && instance_exists(objPlayer) && instance_exists(objItemTutorial)) {
    var item_final = instance_find(objItemTutorial, 0);
    if (item_final != noone && point_distance(objPlayer.x, objPlayer.y, item_final.x, item_final.y) < 32) {
        instance_destroy(item_final);
        if (alarm[0] == -1) alarm[0] = game_get_speed(gamespeed_fps) * 3;
    }
}

if (keyboard_check_pressed(ord("P")) && !exibir_popup && status_tutorial < 6) exibir_popup = true;

if (status_tutorial == 3 && instance_exists(objPlayer) && instance_exists(objLinhaChegada)) {
    var linha = instance_find(objLinhaChegada, 0);
    if (linha != noone && objPlayer.x >= linha.x) {
        fade_estado = "fade_out";
    }
}

if (status_tutorial == 3 && instance_exists(objNpcTutorial)) {
    var npc = instance_find(objNpcTutorial, 0);
    if (npc != noone && npc.tipo == "corredor") {
        var linha = instance_find(objLinhaChegada, 0);
        if (linha != noone && npc.x >= linha.x) {
            npc.velocidade_corrida = 0;
            texto_guia = "You lost! NPC won! Try again.";
            if (alarm[2] == -1) alarm[2] = 90;
        }
    }
}

if (status_tutorial == 4 && instance_exists(objInimigoTutorial) == false && round_atual < 5) {
    round_atual++;
    SpawnEnemies(round_atual);
    texto_guia = "ROUND " + string(round_atual);
    mostrar_round = true;
    round_timer = 60;
    alarm[3] = 60;
}

if (round_timer > 0) {
    round_timer--;
    if (round_timer == 0) {
        mostrar_round = false;
    }
}

if (status_tutorial == 4 && round_atual == 5 && instance_exists(objInimigoTutorial) == false) {
    fade_estado = "fade_out";
}

if (loja_aberta) {
    loja_alpha = min(1, loja_alpha + 0.08);
    loja_scale = min(1, loja_scale + 0.05);
} else {
    loja_alpha = max(0, loja_alpha - 0.08);
    loja_scale = max(0.5, loja_scale - 0.05);
}