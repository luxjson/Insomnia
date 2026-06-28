text_alpha = 0;
text_fade_speed = 0.02;
text_scale = 1.0;

title_text = "GAME OVER";
hope_text = "Even in the deepest dark, the morning eventually finds a way.";

menu_index = 0;
main_options = ["TRY AGAIN", "START NEW GAME"];

save_menu_open = false;
save_index = 0;
save_slots = ["SLOT 1", "SLOT 2", "SLOT 3"];
current_chapter = 1; 

has_any_save = (file_exists("save_0.dat") || file_exists("save_1.dat") || file_exists("save_2.dat") || file_exists("save.dat"));

shake_try = 0;
error_flash_try = 0;
shattered_try = false;
shatter_particles = [];

is_transitioning = false;
slice_count = 8;
slice_max_width = 0;
slice_widths = array_create(slice_count, 0);
slice_speeds = array_create(slice_count, 0);
for(var i = 0; i < slice_count; i++) slice_speeds[i] = random_range(15, 30);
transition_timer = 0;