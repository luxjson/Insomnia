if (show_prompt) {
    var _cam = view_camera[0];
    var _cam_x = camera_get_view_x(_cam);
    var _cam_y = camera_get_view_y(_cam);
    
    var _screen_x = x - _cam_x;
    var _screen_y = y - _cam_y;
    
    var _x = _screen_x;
    var _y = _screen_y - 60;
    var _w1 = 200;
    var _h1 = 36;
    var _bx11 = _x - (_w1 / 2);
    var _by11 = _y - (_h1 / 2);
    var _bx21 = _x + (_w1 / 2);
    var _by21 = _y + (_h1 / 2);
    
    var _offset = sin(current_time / 300) * 4;
    _by11 += _offset;
    _by21 += _offset;
    
    draw_set_color(c_black);
    draw_rectangle(_bx11, _by11, _bx21, _by21, false);
    
    draw_set_color(c_white);
    draw_line_width(_bx11, _by11, _bx21, _by11, 2);
    draw_line_width(_bx11, _by21, _bx21, _by21, 2);
    draw_line_width(_bx11, _by11, _bx11, _by21, 2);
    draw_line_width(_bx21, _by11, _bx21, _by21, 2);
    
    var corner = 6;
    draw_rectangle(_bx11, _by11, _bx11 + corner, _by11 + corner, true);
    draw_rectangle(_bx21 - corner, _by11, _bx21, _by11 + corner, true);
    draw_rectangle(_bx11, _by21 - corner, _bx11 + corner, _by21, true);
    draw_rectangle(_bx21 - corner, _by21 - corner, _bx21, _by21, true);
    
    draw_set_font(global.fonteLegenda);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text(_x, _y + _offset, "[Z] to Interact");
}