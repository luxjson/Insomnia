function url_encode(_str) {
    var _out = "";
    var _len = string_length(_str);
    for (var i = 1; i <= _len; i++) {
        var _char = string_char_at(_str, i);
        var _code = string_byte_at(_str, i);
      
        if ((_code >= 48 && _code <= 57) || (_code >= 65 && _code <= 90) || (_code >= 97 && _code <= 122) || _char == "-" || _char == "_" || _char == "." || _char == "~") {
            _out += _char;
        } else if (_char == " ") {
            _out += "%20"; 
        } else {
            var _hex = "0123456789ABCDEF";
            var _hi = string_char_at(_hex, (_code div 16) + 1);
            var _lo = string_char_at(_hex, (_code mod 16) + 1);
            _out += "%" + _hi + _lo;
        }
    }
    return _out;
}


function scr_show_location(_text, _color, _shadow, _chapter) {
    var inst = instance_create_depth(0, 0, -10000, objShowLocal);
    with (inst) {
        text = _text;
        color = _color;
        shadow = _shadow;
        show_chapter = _chapter;
    }
}