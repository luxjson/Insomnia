enum MENU_STATE {
    MAIN,
    SETTINGS,
    CREDITS
}
current_state = MENU_STATE.MAIN;

current_bg = sprMenu;
fade_target_bg = sprMenu;

menu_alpha = 1.0;
fade_target_state = MENU_STATE.MAIN;
fade_target_room = -1;
is_fading = false;
fade_speed = 0.05; 

if (!variable_global_exists("vol_bgm"))     global.vol_bgm = 1.0;
if (!variable_global_exists("vol_sfx"))     global.vol_sfx = 1.0;
if (!variable_global_exists("fullscreen"))  global.fullscreen = window_get_fullscreen();
if (!variable_global_exists("achievements")) global.achievements = true;

ini_open("configuracoes.ini");
global.fullscreen   = ini_read_real("Video", "Fullscreen", global.fullscreen);
global.vol_bgm      = ini_read_real("Audio", "Volume_BGM", global.vol_bgm);
global.vol_sfx      = ini_read_real("Audio", "Volume_SFX", global.vol_sfx);
global.achievements = ini_read_real("Gameplay", "Achievements", global.achievements);
ini_close();

window_set_fullscreen(global.fullscreen);

main_options = ["START GAME", "SETTINGS", "CREDITS", "EXIT"];
settings_options = ["FULLSCREEN: ", "BGM VOLUME: ", "SFX VOLUME: ", "ACHIEVEMENTS: ", "BACK"];
credits_text = ["INSOMNIA TEAM", "", "Director\nLUXJSON", "", "Programmer\nLUXJSON", "", "Artist\nISABELLA SANCHES", "", "Sprites\nSSCARY", "", "THANK YOU FOR PLAYING!", "", "BACK"];

spacing = 45;

if (!audio_is_playing(mus_menu)) {
    audio_play_sound(mus_menu, 10, true);
}