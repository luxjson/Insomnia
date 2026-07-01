global.current_chapter = 1;
started_story = false;

if (!audio_is_playing(mus_chapter1Maze)) {
    var som_chapter1Maze = audio_play_sound(mus_chapter1Maze, 10, true);
    audio_sound_gain(som_chapter1Maze, global.vol_bgm, 0);
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
