hspd = 0;
vspd = 0;
spd = 4.5;
state = "idle"; 
dir = 0; 

spr_idle  = sprPlayerIdle;
spr_walk  = sprPlayerWalk;
spr_dash  = sprPlayerDash;
spr_death = sprPlayerDeath;
save_menu_open = false;
array_inventario = [];

frame_w = 32; 
frame_h = 32; 
anim_frame = 0;
anim_speed = 0.15;
num_frames = 4;

var user_name = "Abby";

current_chapter = 1;
has_any_save = file_exists("save.json");

shake_continue = 0;
error_flash_continue = 0;
click_count_continue = 0;
shattered_continue = false;
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

config_open = false;
config_y = -400;
config_target_y = -400;
config_anim_speed = 0.15;
config_tab = 0; 
config_idx = 0;
config_cooldown = 0;
depth = -y;

death_timer = 0;       
death_cooldown = 0;    
is_dead = false;       

dash_spd = 10     
dash_dur = 20;      
dash_timer = 0;
is_dashing = false;
dash_dir = 0;
anim_speed_dash = 0.3;  

menu_sub_state = "main"; 
key_z = false;
box_selected_opt = 0;
sub_menu_idx = 0;

base_atk = 10;
base_def = 5;
hp_actual = 20;
hp_max = 20;

stat_atk = base_atk;
stat_def = base_def;

equipped_weapon = "NONE";
equipped_shield = "NONE";

attack_cooldown = 0;
attack_cooldown_max = 15;
attack_range = 30;
attack_step = 20;
base_damage = 2;
combo_count = 0;
combo_timer = 0;
combo_max_time = 60;
is_attacking = false;
attack_damage_display = 0;

inventory = [
    { name: "STICK", type: "weapon", sprite: sprPlayerIdle, value: 2, info: "+2 ATK" },
    { name: "BANDAGE", type: "shield", sprite: sprPlayerIdle, value: 1, info: "+1 DEF" },
    { name: "BREAD", type: "heal", sprite: sprPlayerIdle, value: 10, info: "HEAL 10 HP" }
];