if (!sleeping && !transition_complete && instance_exists(objPlayer)) {
    if (point_distance(x, y, objPlayer.x, objPlayer.y) < 50) {
        if (keyboard_check_pressed(ord("Z"))) {
            sleeping = true;
            with (objPlayer) {
                state = "idle";
                hspd = 0;
                vspd = 0;
            }
        }
    }
}

if (sleeping && !transition_complete) {
    if (wait_counter < wait_frames) {
        wait_counter++;
        exit;
    }
    var view_id = view_camera[0];
    if (view_id >= 0) {
        var view_w = camera_get_view_width(view_id);
        var view_h = camera_get_view_height(view_id);
        var target_w = view_w * zoom_target;
        var target_h = view_h * zoom_target;
        var current_w = lerp(view_w, target_w, zoom_speed);
        var current_h = lerp(view_h, target_h, zoom_speed);
        camera_set_view_size(view_id, current_w, current_h);
        if (instance_exists(objPlayer)) {
            var cam_x = objPlayer.x - (current_w / 2);
            var cam_y = objPlayer.y - (current_h / 2);
            camera_set_view_pos(view_id, cam_x, cam_y);
        }
    }
    fade_alpha = min(1, fade_alpha + fade_speed);
    if (fade_alpha >= 1) {
        transition_complete = true;
        alarm[0] = 15;
    }
}