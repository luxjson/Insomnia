var next_msg = array_shift(dialogue_queue);
msg_name = next_msg.speaker_name;
msg_text = next_msg.text_string;
msg_speed = next_msg.text_speed;
msg_color = next_msg.text_color;
msg_font = next_msg.text_font;
msg_portrait = next_msg.portrait_sprite;
char_index = 0;
displayed_text = "";
text_cooldown = 0;
current_dialogue = 1;

if (next_msg.is_custom_choice) {
    is_choice_mode = true;
    choice_selected = 0;
    choice_text_1 = next_msg.b1;
    choice_text_2 = next_msg.b2;
    reaction_text_1 = next_msg.r1;
    reaction_text_2 = next_msg.r2;
} else {
    is_choice_mode = false;
}