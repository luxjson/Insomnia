text_state = 0;
text_timer = 0;
text_duration = 250;
text_fade_speed = 0.03;
text_alpha = 0;
current_text_index = 0;
show_choice_menu = false;
choice_index = 0;

dev_texts = [
    "ATTENTION: This sector of the game is currently under DEVELOPMENT.",
    "Features, assets, and code are being implemented by the team.",
    "You can wait for future UPDATES or test our current systems.",
    "While we finish this area, you can play a quick arcade MINIGAME."
];

menu_options = ["PLAY MINIGAME", "EXIT TO DESKTOP"];

enum MINIGAME_STATE {
    INTRO,
    PLAYING,
    GAMEOVER,
    VICTORY
}
game_state = MINIGAME_STATE.INTRO;
score_points = 0;

player_x = display_get_gui_width() / 2;
player_y = display_get_gui_height() - 80;
player_speed = 7; 
player_cooldown = 0;
player_lives = 5;
player_last_x = player_x;

star_count = 30;
star_list = array_create(star_count);
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
for (var i = 0; i < star_count; i++) {
    star_list[i] = {
        xx: random(gui_w),
        yy: random(gui_h),
        spd: random_range(0.5, 2.0),
        alpha: random_range(0.2, 0.7)
    };
}

player_lasers = [];
enemies = [];
enemy_lasers = [];

enemy_spawn_timer = 0;

end_menu_index = 0;
gameover_options = ["TRY AGAIN", "EXIT TO DESKTOP"];
victory_options = ["SHARE ON TWITTER", "EXIT TO DESKTOP"];

menu_input_delay = 60;