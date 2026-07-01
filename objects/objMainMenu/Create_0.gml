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
selected_option = 0;



main_options = ["START GAME", "SETTINGS", "CREDITS", "EXIT"];
settings_options = ["FULLSCREEN: ", "BGM VOLUME: ", "SFX VOLUME: ", "ACHIEVEMENTS: ", "BACK"];
credits_text = ["INSOMNIA TEAM", "", "Director\nLUXJSON", "", "Programmer\nLUXJSON", "", "Artist\nISABELLA SANCHES", "", "Sprites\nSSCARY", "", "THANK YOU FOR PLAYING!", "", "Press [X] to go back"];

spacing = 45;

