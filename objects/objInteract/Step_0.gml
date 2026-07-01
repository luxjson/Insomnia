if (cooldown > 0) cooldown--;

if (!instance_exists(objPlayer)) exit;

var dist = point_distance(x, y, objPlayer.x, objPlayer.y);

var dentro_do_raio = (dist < trigger_distance && !is_triggered && !instance_exists(objDialogue) && !instance_exists(objInteractSystem));

var e_o_mais_perto = false;
if (dentro_do_raio) {
    var closest_interact = instance_nearest(objPlayer.x, objPlayer.y, objInteract);
    if (closest_interact == id) {
        e_o_mais_perto = true;
    }
}

show_prompt = e_o_mais_perto;
if (show_prompt && keyboard_check_pressed(ord("Z")) && objPlayer.config_open == false) {
    is_triggered = true;
    Interact(interact_title, interact_text, interact_color);
    cooldown = 10;
}

if (is_triggered && !instance_exists(objDialogue)) {
    is_triggered = false;
}