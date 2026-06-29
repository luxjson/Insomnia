if (!transition_complete) {
    var view_id = view_camera[0];
    if (view_id >= 0) {
        camera_set_view_size(view_id, 1920, 1080);
    }
}