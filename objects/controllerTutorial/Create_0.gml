status_tutorial = 1;
texto_guia = "Aperte E para falar com os NPCs imóveis.";

fade_alpha = 0;
fade_estado = "fade_in";
player_hp = 100;
player_max_hp = 100;
forca_barra = 0;
total_inimigos_p4 = 3;

letreiro_x = 0;
letreiro_velocidade = 2;
tempo_botao_z = 0;
inv_shift_x = 0;


forca_barra = 0;
barra_subindo = true;
barra_velocidade = 0.04;
combo_atual = 0;
texto_combo = "";
texto_combo_alpha = 0;
dano_aplicado = 0;
zoom_alvo = 1.0;
zoom_atual = 1.0;


npcs_falados = 0;
total_npcs_p1 = 5;
corrida_iniciada = false;

inventario_aberto = false;
itens_coletados = 0;
item_arrastado_index = -1;
itens_removidos_count = 0;

fullscreen = false;
audio_volume = 1.0;
achievements_enabled = true;

ini_open("configuracoes.ini");
fullscreen = ini_read_real("Video", "Fullscreen", false);
audio_volume = ini_read_real("Audio", "Volume", 1.0);
achievements_enabled = ini_read_real("Gameplay", "Achievements", true);
ini_close();

window_set_fullscreen(fullscreen);
audio_master_gain(audio_volume);

modo_combate = false;
forca_barra = 0;
barra_subindo = true;
barra_velocidade = 0.04;
combo_atual = 0;
texto_combo = "";
texto_combo_alpha = 0;
dano_aplicado = 0;
zoom_alvo = 1.0;
zoom_atual = 1.0;
letreiro_x = 0;
letreiro_velocidade = 2;
inv_shift_x = 0;

menu_aberto = false;
menu_y_anim = -1080;
aba_selecionada = 0;
menu_opcao_vertical = 0;

sub_menu_estado = "normal";   // "normal", "save_slots", "drop_confirm"
menu_save_tipo = "carregar";  // "carregar", "excluir", "salvar"
slot_selecionado = 0;

slot_inv_selecionado = 0;
item_sub_opcao = 0;           // 0 = DROP, 1 = CANCELAR
foco_aba = true;
delay_entrada = 0;
delay_submenu = 0;
itens_removidos_count = 0;
exibir_popup = false;

if (!audio_is_playing(snd_tutorial)) {
    audio_play_sound(snd_tutorial, 10, true);
}

if (!variable_global_exists("fonteNormal")) {
    global.fonteNormal = -1; 
}

ResetScene(1);