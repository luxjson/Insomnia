text_alpha = 0;
text_fade_speed = 0.03;
text_scale = 1.0;

title_text = "GAME OVER";
hope_text = "Even in the deepest dark, the morning eventually finds a way.";

menu_index = 0;
main_options = ["TRY AGAIN", "START NEW GAME"];

save_menu_open = false;
save_index = 0;
save_slots = ["SLOT 1", "SLOT 2", "SLOT 3"];
current_chapter = 1; 

has_any_save = file_exists("save.json");

shake_try = 0;
shattered_try = false;
shatter_particles = [];

for (var i = 0; i < 60; i++) {
    array_push(shatter_particles, {
        xx: random(display_get_gui_width()),
        yy: random(display_get_gui_height()),
        vx: random_range(-0.3, 0.3),
        vy: random_range(0.2, 0.8),
        size: random_range(2, 6),
        alpha: random_range(0.1, 0.4),
        color: choose(c_white, c_red, c_gray)
    });
}

is_transitioning = false;
fade_alpha = 0;
transition_timer = 0;