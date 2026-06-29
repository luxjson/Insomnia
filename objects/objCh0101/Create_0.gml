global.current_chapter = 1;

if (!audio_is_playing(mus_chapter1Maze)) {
    var som_chapter1Maze = audio_play_sound(mus_chapter1Maze, 10, true);
    audio_sound_gain(som_chapter1Maze, global.vol_bgm, 0);
}

scr_show_location("THE WALL", c_yellow, true, false);
alarm[0] = room_speed * 2.5;