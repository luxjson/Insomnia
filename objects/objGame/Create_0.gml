enum MENU_STATE_2 { MAIN, SETTINGS, CREDITS }

current_state = MENU_STATE_2.MAIN;
menu_alpha = 1.0;
text_state = 0;
text_timer = 0;
text_duration = 300;
text_fade_speed = 0.02;
text_alpha = 0;
current_text_index = 0;
choice_index = 0;
global.history_answers = array_create(7, -1);

var user_name = string_upper(environment_get_variable("USERNAME"));
if (user_name == "") user_name = "player";

history_texts = [
    "Today was an absolute nightmare.",
    "I just wanted to get back to my room in one piece.",
    "But every single step feels so heavy, like the world is pushing against me.",
    "The crowd outside was suffocating today, moving so fast, chasing empty things.",
    "I just stood there, drowning in the noise, completely unable to keep up.",
    "Then, a car missed me by an inch on the main avenue.",
    "I didn't jump, scream, or flinch. I just stood frozen on the asphalt.",
    "The driver didn't look back. For a second, my heart stopped entirely.",
    "And honestly? A quiet part of me didn't care if it hit me.",
    "Now I am back in the dark of my room, and the numbness is taking over again.",
    "It's not a tiredness that sleep can fix. It's an exhaustion inside my bones.",
    "Tell me...",
    "Have you ever felt a weight like this? A weight that makes breathing feel like a chore?",
    "",
    "Do you ever look at a crowd of people and feel completely, entirely alone?",
    "",
    "Have you ever stood frozen, watching danger approach, and felt absolutely no fear?",
    "",
    "Does a part of you ever whisper that it would be easier if you just... stopped trying?",
    "",
    "Do you know what it's like to look at your future and see nothing but blank space?",
    "",
    "When you close your eyes, do you still remember what the light feels like?",
    "",
    "Are you just going through the motions out of pure habit too?",
    "",
    "",
    "I understand, " + string(user_name) + ".",
    "Tomorrow will be a better DAY."
];

history_choices = [
    ["Yes, every day.", "Only sometimes.", "No, not really."],
    ["Always.", "When it gets dark.", "Never."],
    ["I know that feeling.", "It sounds terrifying.", "I value my life."],
    ["It talks to me daily.", "Occasionally.", "I fight those thoughts."],
    ["Nothing but void.", "It is blurry.", "I see my goals."],
    ["I forgot it.", "It is fading.", "Yes, clearly."],
    ["Yes, like a machine.", "I am trying not to.", "No, I am living."]
];

game_replies = [
    ["A suffocating armor... I know.", "Be careful, those moments can expand.", "I'm glad your body still feels light."],
    ["The worst kind of isolation is around others.", "The shadows have a way of doing that.", "Keep holding onto that connection."],
    ["An eerie calmness, isn't it?", "It is. The survival instinct just... breaks.", "Good. Never lose that spark."],
    ["It's a dangerously seductive whisper.", "Don't let it become a constant voice.", "Keep fighting it. Don't let it win."],
    ["A blinding mist... it's terrifying.", "Uncertainty can feel just as heavy.", "Hold onto that vision. It's your anchor."],
    ["The darkness is a cruel thief.", "Then try to remember before it slips away.", "Never forget how warm it feels."],
    ["Like clockwork without a soul.", "Breaking the cycle takes everything.", "Live fully, while you still can."]
];

current_chapter = 1;
show_menu_buttons = false;
menu_index = 0;
config_open = false;
config_y = -400;
config_target_y = -400;
config_anim_speed = 0.15;
config_tab = 0;
config_idx = 0;
config_cooldown = 0;
is_rebinding = false;
keyboard_lastkey = -1;

save_menu_open = false;
has_any_save = file_exists("save.json");

shake_continue = 0;
shake_load = 0;
error_flash_continue = 0;
error_flash_load = 0;
click_count_continue = 0;
click_count_load = 0;
shattered_continue = false;
shattered_load = false;
shatter_particles = [];

if (!variable_global_exists("vol_bgm")) global.vol_bgm = 1.0;
if (!variable_global_exists("vol_sfx")) global.vol_sfx = 1.0;
if (!variable_global_exists("fullscreen")) global.fullscreen = window_get_fullscreen();
if (!variable_global_exists("achievements")) global.achievements = true;
if (!variable_global_exists("contrast_value")) global.contrast_value = 1.0;

resolutions = [[1280, 720], [1600, 900], [1920, 1080]];

ini_open("configuracoes.ini");
global.fullscreen = ini_read_real("Video", "Fullscreen", global.fullscreen);
global.vol_bgm = ini_read_real("Audio", "Volume_BGM", global.vol_bgm);
global.vol_sfx = ini_read_real("Audio", "Volume_SFX", global.vol_sfx);
global.achievements = ini_read_real("Gameplay", "Achievements", global.achievements);
global.contrast_value = ini_read_real("Video", "Contrast", global.contrast_value);
resolution_index = ini_read_real("Video", "ResolutionIndex", 0);
text_scale = ini_read_real("Interface", "TextScale", 1.0);

controls = [
    ["MOVE LEFT",  ini_read_real("Controls", "Left",  vk_left)],
    ["MOVE RIGHT", ini_read_real("Controls", "Right", vk_right)],
    ["ACTION Z",   ini_read_real("Controls", "Z",     ord("Z"))],
    ["BACK X",     ini_read_real("Controls", "X",     ord("X"))]
];

ini_close();

window_set_fullscreen(global.fullscreen);
var res = resolutions[resolution_index];
window_set_size(res[0], res[1]);
display_set_gui_size(res[0], res[1]);

main_options = ["NEW GAME", "CONTINUE FROM CHAPTER " + string(current_chapter), "SETTINGS"];

max_pixels = 40;
pixel_list = array_create(max_pixels);
for (var i = 0; i < max_pixels; i++) {
    pixel_list[i] = {
        xx: random(display_get_gui_width()),
        yy: random(display_get_gui_height()),
        spd: random_range(0.5, 1.5),
        size: choose(5, 6)
    };
}

is_transitioning = false;
slice_count = 8;
slice_max_width = 0;
slice_widths = array_create(slice_count, 0);
slice_speeds = array_create(slice_count, 0);
for (var i = 0; i < slice_count; i++) slice_speeds[i] = random_range(15, 30);
transition_timer = 0;