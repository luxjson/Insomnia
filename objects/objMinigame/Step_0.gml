if (cooldown > 0) cooldown--;
if (puzzle_solved) exit;
if (!instance_exists(objPlayer)) exit;
if (objPlayer.config_open) exit;

var dist = point_distance(x, y, objPlayer.x, objPlayer.y);
show_prompt = (dist < trigger_distance && !objPlayer.config_open);

if (show_prompt && keyboard_check_pressed(ord("Z"))) {
    StartPuzzle(x, y);
}