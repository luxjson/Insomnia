selected_option = 0;
options = ["BEGIN GAME", "JOYSTICK CONFIG"];
controls_list = [
    "[ARROWS] - Move",
    "[Z] - Confirm",
    "[X] - Cancel",
    "[C] - Menu (In-game)",
    "[F4] - Fullscreen",
    "When HP is 0, you lose."
];
title_text = "INSOMNIA v0.11b (C) SOMIARI GAMES";
target_menu_room = rm_Intro;

if (!variable_global_exists("vol_bgm")) global.vol_bgm = 1.0;
if (!variable_global_exists("vol_sfx")) global.vol_sfx = 1.0;
if (!variable_global_exists("fullscreen")) global.fullscreen = window_get_fullscreen();
if (!variable_global_exists("achievements")) global.achievements = true;

ini_open("configuracoes.ini");
global.fullscreen = ini_read_real("Video", "Fullscreen", global.fullscreen);
global.vol_bgm = ini_read_real("Audio", "Volume_BGM", global.vol_bgm);
global.vol_sfx = ini_read_real("Audio", "Volume_SFX", global.vol_sfx);
global.achievements = ini_read_real("Gameplay", "Achievements", global.achievements);
ini_close();

window_set_fullscreen(global.fullscreen);

if (!audio_is_playing(StartMenu)) {
    global.music_id = audio_play_sound(StartMenu, 10, true);
    audio_sound_gain(global.music_id, global.vol_bgm, 0);
}