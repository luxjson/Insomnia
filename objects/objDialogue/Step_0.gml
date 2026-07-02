if (current_dialogue == -1) exit;

var key_z = keyboard_check_pressed(ord("Z"));
var key_left = keyboard_check_pressed(vk_up);
var key_right = keyboard_check_pressed(vk_down);

if (char_index < string_length(msg_text)) {
    is_typing = true;
    
    var current_speed = msg_speed;
    text_cooldown += current_speed;
    
    if (text_cooldown >= 1) {
        var count = floor(text_cooldown);
        text_cooldown -= count;
        char_index += count;
        displayed_text = string_copy(msg_text, 1, char_index);
        
        if (string_char_at(msg_text, char_index) != " ") {
            var sfx = audio_play_sound(Beep, 1, false);
            if (variable_global_exists("vol_sfx")) audio_sound_gain(sfx, global.vol_sfx, 0);
        }
    }
    if (key_z) {
        char_index = string_length(msg_text);
        displayed_text = msg_text;
    }
} else {
    is_typing = false;
    if (is_choice_mode) {
        if (key_left || key_right) {
            choice_selected = (choice_selected == 0) ? 1 : 0;
            var sfx = audio_play_sound(Beep, 1, false);
            if (variable_global_exists("vol_sfx")) audio_sound_gain(sfx, global.vol_sfx, 0);
        }
        if (key_z) {
            var selected_reaction = (choice_selected == 0) ? reaction_text_1 : reaction_text_2;
            
            if (selected_reaction != "") {
                var first_word = string_copy(selected_reaction, 1, 5);
                if (first_word == "Abby:") {
                    var real_text = string_copy(selected_reaction, 7, string_length(selected_reaction) - 6);
                    array_insert(dialogue_queue, 0, {
                        speaker_name: "Abby",
                        text_string: real_text,
                        text_speed: msg_speed,
                        text_color: msg_color,
                        text_font: msg_font,
                        portrait_sprite: -1,
                        is_custom_choice: false,
                        b1: "", b2: "", r1: "", r2: ""
                    });
                } else {
                    array_insert(dialogue_queue, 0, {
                        speaker_name: "",
                        text_string: selected_reaction,
                        text_speed: msg_speed,
                        text_color: msg_color,
                        text_font: msg_font,
                        portrait_sprite: -1,
                        is_custom_choice: false,
                        b1: "", b2: "", r1: "", r2: ""
                    });
                }
                is_choice_mode = false;
                event_user(0);
            } else {
                if (array_length(dialogue_queue) > 0) {
                    is_choice_mode = false;
                    event_user(0);
                } else {
                    current_dialogue = -1;
                    instance_destroy();
                }
            }
        }
    } else {
        if (key_z) {
            if (array_length(dialogue_queue) > 0) {
                event_user(0);
            } else {
                current_dialogue = -1;
                instance_destroy();
            }
        }
    }
}

if (is_choice_mode && key_z) {
    global.last_dialogue_choice = choice_selected;
}