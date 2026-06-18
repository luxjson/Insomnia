status = 0;
logo_alpha = 0;
menu_fade = 1;
progresso = 0;
tempo_carregamento = game_get_speed(gamespeed_fps) * 3;

if (!variable_global_exists("ja_viu_a_splash")) {
    global.ja_viu_a_splash = false;
}

if (global.ja_viu_a_splash) {
    instance_destroy();
} else {
    display_set_gui_size(window_get_width(), window_get_height());
    alarm[0] = game_get_speed(gamespeed_fps) * 0.5;
}

ini_open("configuracoes.ini");
fullscreen = ini_read_real("Video", "Fullscreen", false);
audio_volume = ini_read_real("Audio", "Volume", 1.0);
achievements_enabled = ini_read_real("Gameplay", "Achievements", true);
ini_close();

window_set_fullscreen(fullscreen);
audio_master_gain(audio_volume);
game_set_speed(60, gamespeed_fps);