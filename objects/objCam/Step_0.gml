if (!instance_exists(objPlayer)) exit;

var target_x = objPlayer.x - (cam_w / 2);
var target_y = objPlayer.y - (cam_h / 2);

cam_x = lerp(cam_x, target_x, cam_speed);
cam_y = lerp(cam_y, target_y, cam_speed);

if (room_width > cam_w) {
    cam_x = clamp(cam_x, 0, room_width - cam_w);
}
if (room_height > cam_h) {
    cam_y = clamp(cam_y, 0, room_height - cam_h);
}

camera_set_view_pos(cam_id, cam_x, cam_y);