function dialogue(_name, _text, _speed, _color, _font, _portrait) {
    if (!instance_exists(objDialogue)) {
        instance_create_depth(0, 0, -9999, objDialogue);
    }
    with (objDialogue) {
        array_push(dialogue_queue, {
            speaker_name: _name,
            text_string: _text,
            text_speed: _speed,
            text_color: _color,
            text_font: _font,
            portrait_sprite: _portrait,
            is_custom_choice: false,
            b1: "", b2: "", r1: "", r2: ""
        });
        if (current_dialogue == -1) event_user(0);
    }
}

function dialogue_choice(_text, _speed, _color, _font, _button1, _button2, _reaction1, _reaction2) {
    if (!instance_exists(objDialogue)) {
        instance_create_depth(0, 0, -9999, objDialogue);
    }
    with (objDialogue) {
        array_push(dialogue_queue, {
            speaker_name: "CHOICE",
            text_string: _text,
            text_speed: _speed,
            text_color: _color,
            text_font: _font,
            portrait_sprite: -1,
            is_custom_choice: true,
            b1: _button1,
            b2: _button2,
            r1: _reaction1,
            r2: _reaction2
        });
        if (current_dialogue == -1) event_user(0);
    }
}