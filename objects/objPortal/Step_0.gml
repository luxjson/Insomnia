if (state == "idle" && !transitioning) {
    if (!instance_exists(objPlayer)) exit;
    var dist = point_distance(x, y, objPlayer.x, objPlayer.y);
    show_prompt = (dist < trigger_distance);
    if (show_prompt && keyboard_check_pressed(ord("Z"))) {
        if (instance_exists(objPlayer)) {
            objPlayer.visible = false;
        }
        state = "wakedown";
        sprite_index = sprPortalWakedown;
        image_speed = 0.2;
        image_index = 0;
        show_prompt = false;
		if (audio_is_playing(MazeOfMemories)) {
		    audio_stop_sound(MazeOfMemories)
		}
    }
}