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


function scr_calculate_damage(_atk, _def) {
    var _base = _atk;
    var _reduction = _def * 0.2;
    var _damage = max(1, ceil(_base - _reduction));
    if (random(100) < 10) {
        _damage = ceil(_damage * 1.5);
        return { damage: _damage, critical: true };
    }
    return { damage: _damage, critical: false };
}

function scr_deal_damage(_target, _damage, _knockback_dir, _knockback_power) {
    if (!instance_exists(_target)) return;
    
    _target.hp -= _damage;
    _target.hit_timer = 10;
    _target.flash_timer = 8;
    
    _target.knockback = true;
    _target.knockback_dir = _knockback_dir;
    _target.knockback_power = _knockback_power;
    _target.knockback_timer = 8;
    
    with (instance_create_depth(_target.x, _target.y - 20, -100, objFloatingText)) {
        text = "-" + string(_damage);
        color = c_red;
        duration = 40;
    }
    
    if (_target.hp <= 0) {
        _target.hp = 0;
        with (instance_create_depth(_target.x, _target.y, -100, objFloatingText)) {
            text = "VICTORY!";
            color = c_yellow;
            duration = 60;
            scale = 1.5;
        }
        instance_destroy(_target);
    }
}