if (!instance_exists(objPlayer)) exit;
if (transition_complete) exit;

if (sleeping) {
    curtain_progress = min(1, curtain_progress + curtain_speed);
    if (curtain_progress >= 1) {
        transition_complete = true;
        alarm[0] = 15;
    }
    exit;
}

if (pending_sleep && !instance_exists(objDialogue)) {
    pending_sleep = false;
    sleeping = true;
    with (objPlayer) {
        state = "idle";
        hspd = 0;
        vspd = 0;
    }
    exit;
}

var dist = point_distance(x, y, objPlayer.x, objPlayer.y);
show_prompt = (dist < trigger_distance && !instance_exists(objDialogue));

if (show_prompt && keyboard_check_pressed(ord("Z"))) {
    Interact(interact_title, interact_text, interact_color);
    pending_sleep = true;
}