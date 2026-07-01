if (hit_timer > 0) hit_timer--;
if (flash_timer > 0) flash_timer--;

if (knockback) {
    var kx = lengthdir_x(knockback_power, knockback_dir);
    var ky = lengthdir_y(knockback_power, knockback_dir);
    x += kx;
    y += ky;
    knockback_timer--;
    if (knockback_timer <= 0) {
        knockback = false;
    }
    exit;
}

if (!instance_exists(objPlayer)) exit;

var dist = point_distance(x, y, objPlayer.x, objPlayer.y);

if (dist < chase_range) {
    state = "chase";
} else {
    state = "idle";
}

if (state == "chase") {
    var dir = point_direction(x, y, objPlayer.x, objPlayer.y);
    var move_x = lengthdir_x(speed, dir);
    var move_y = lengthdir_y(speed, dir);
    
    if (place_meeting(x + move_x, y, obj)) {
        while (!place_meeting(x + sign(move_x), y, obj)) {
            x += sign(move_x);
        }
        move_x = 0;
    }
    x += move_x;
    
    if (place_meeting(x, y + move_y, obj)) {
        while (!place_meeting(x, y + sign(move_y), obj)) {
            y += sign(move_y);
        }
        move_y = 0;
    }
    y += move_y;
}

if (dist < attack_range && state == "chase" && hit_timer == 0) {
    var dmg = attack_damage;
    if (variable_global_exists("player_def")) {
        dmg = max(1, attack_damage - global.player_def * 0.3);
    }
    if (instance_exists(objPlayer)) {
        objPlayer.hp_actual -= dmg;
        hit_timer = 30;
        with (instance_create_depth(objPlayer.x, objPlayer.y - 20, -100, objFloatingText)) {
            text = "-" + string(dmg);
            color = c_red;
            duration = 30;
        }
        if (objPlayer.hp_actual <= 0) {
            objPlayer.hp_actual = 0;
            objPlayer.state = "death";
        }
    }
}