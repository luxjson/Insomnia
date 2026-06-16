status_tutorial = 1;
texto_guia = "Aperte E para falar com os NPCs imóveis.";

fade_alpha = 0;
fade_estado = "fade_in";
player_hp = 100;
player_max_hp = 100;
forca_barra = 0;
total_inimigos_p4 = 3;

npcs_falados = 0;
total_npcs_p1 = 5;
corrida_iniciada = false;

inventario_aberto = false;
itens_coletados = 0;
item_arrastado_index = -1;
itens_removidos_count = 0;

exibir_popup = false;

if (!audio_is_playing(snd_tutorial)) {
    audio_play_sound(snd_tutorial, 10, true);
}

if (!variable_global_exists("fonteNormal")) {
    global.fonteNormal = -1; 
}

ResetScene(1);