global.current_chapter = 1;
started_story = false;

CreateInteract(1490, 318, "???", "HELLOOOO!!!!! Welcome to your mind, Mila!!!!", c_white, 50);
CreateInteract(2650, 330, "???", "OOOMG, IT'S RELLY YOU MILA!!!!!", c_white, 50);


if (audio_is_playing(AbbyMind)) {
    audio_stop_sound(AbbyMind)
}

if (!audio_is_playing(MazeOfMemories)) {
    global.music_id = audio_play_sound(MazeOfMemories, 10, true);
    audio_sound_gain(global.music_id, global.vol_bgm, 0);
}

if (variable_global_exists("load_data") && global.load_data != undefined) {
    if (variable_struct_exists(global.load_data, "started_story")) {
        started_story = global.load_data.started_story;
    }
}

scr_show_location("Maze Of Memories", c_white, true, 1);

if (!started_story) {
	alarm[0] = room_speed * 2.5;
}

global.isMila = true