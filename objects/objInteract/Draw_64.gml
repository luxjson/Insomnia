if (show_prompt) {
    var _cam = view_camera[0];
    var _cam_x = camera_get_view_x(_cam);
    var _cam_y = camera_get_view_y(_cam);
    
    var _screen_x = x - _cam_x;
    var _screen_y = y - _cam_y;
    
    var _x = _screen_x;
    var _y = _screen_y - 60;
    var _w = 200;
    var _h = 36;
    var _bx1 = _x - (_w / 2);
    var _by1 = _y - (_h / 2);
    var _bx2 = _x + (_w / 2);
    var _by2 = _y + (_h / 2);
    
    var _offset = sin(current_time / 300) * 4;
    _by1 += _offset;
    _by2 += _offset;
    
    draw_set_color(c_black);
    draw_rectangle(_bx1, _by1, _bx2, _by2, false);
    
    draw_set_color(c_white);
    draw_line_width(_bx1, _by1, _bx2, _by1, 2);
    draw_line_width(_bx1, _by2, _bx2, _by2, 2);
    draw_line_width(_bx1, _by1, _bx1, _by2, 2);
    draw_line_width(_bx2, _by1, _bx2, _by2, 2);
    
    var corner = 6;
    draw_rectangle(_bx1, _by1, _bx1 + corner, _by1 + corner, true);
    draw_rectangle(_bx2 - corner, _by1, _bx2, _by1 + corner, true);
    draw_rectangle(_bx1, _by2 - corner, _bx1 + corner, _by2, true);
    draw_rectangle(_bx2 - corner, _by2 - corner, _bx2, _by2, true);
    
    draw_set_font(global.fonteLegenda);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text(_x, _y + _offset, "[Z] to Interact");
}