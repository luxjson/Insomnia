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


function scr_show_location(_text, _color, _shadow, _chapter_number) {
    if (instance_exists(objShowLocal)) {
        with (objShowLocal) instance_destroy();
    }
    var inst = instance_create_depth(0, 0, -10000, objShowLocal);
    with (inst) {
        text = _text;
        color = _color;
        shadow = _shadow;
        chapter_number = _chapter_number;
    }
}

function CreateInteract(_x, _y, _title, _text, _color, _dist) {
    show_debug_message("CreateInteract chamado! X:" + string(_x) + " Y:" + string(_y));
    with (instance_create_layer(_x, _y, "Instances", objInteract)) {
        interact_title = _title;
        interact_text = _text;
        interact_color = _color;
        trigger_distance = _dist;
    }
}

function Interact(_title, _text, _color) {
    if (!instance_exists(objInteractSystem)) {
        instance_create_depth(0, 0, -1000, objInteractSystem);
    }
    if (!variable_global_exists("interact_queue")) global.interact_queue = [];
    array_push(global.interact_queue, {
        title: _title,
        text: _text,
        color: _color
    });
}

function StartPuzzle(_x, _y) {
    if (global.puzzle_solved) return;
    if (global.puzzle_active) return;
    if (instance_exists(objMinigamePuzzle)) return;
    global.puzzle_active = true;
    with (instance_create_depth(0, 0, -10000, objMinigamePuzzle)) {
        puzzle_x = _x;
        puzzle_y = _y;
    }
}

function scr_set_objective(_text) {
    global.current_objective = _text;
}

function close_portal() {
    if (state == "idle" || state == "wakedown") {
        if (instance_exists(objPlayer)) {
            objPlayer.visible = true;
        }
        instance_destroy();
    }
}

function start_transition() {
    if (transitioning) return;
    transitioning = true;
    with (instance_create_depth(0, 0, -10000, objTransition)) {
        target_room = other.target_room;
    }
    instance_destroy();
}