started_story = false;
alarm_triggered = false;
scr_set_objective("Go to sleep");

if (audio_is_playing(StartMenu)) {
    audio_stop_sound(StartMenu)
}

if (!audio_is_playing(AbbyMind)) {
    global.music_id = audio_play_sound(AbbyMind, 10, true);
    audio_sound_gain(global.music_id, global.vol_bgm, 0);
}



if (variable_global_exists("load_data") && global.load_data != undefined) {
    if (variable_struct_exists(global.load_data, "started_story")) {
        started_story = global.load_data.started_story;
    }
}


CreateInteract(500, 330, "WARDROBE", "I really should organize this wardrobe. I'm getting old, still living alone... and god, what a disaster.", c_white, 50);
CreateInteract(700, 590, "WINDOW", "* You approach the window and the world answers. 'It's a waste to have you trapped in here...'", c_aqua, 50);
CreateInteract(850, 300, "DRAWERS", "Ugh... so many clothes to fold. Just looking at this makes me tired.", c_white, 50);

scr_show_location("Abby's Bedroom", c_white, true, 1);

if (!started_story) {
    alarm[1] = room_speed * 2.8;
}
