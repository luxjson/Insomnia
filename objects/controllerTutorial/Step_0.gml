if (fade_estado == "fade_out") {
    if (fade_alpha < 1) fade_alpha += 0.04;
    else fade_estado = "switch";
} else if (fade_estado == "fade_in") {
    if (fade_alpha > 0) fade_alpha -= 0.04;
}

if (fade_estado == "switch") {
    if (status_tutorial == 1) {
        ResetScene(3);
    } else {
        ResetScene(status_tutorial + 1);
    }
    fade_estado = "fade_in";
}

if (status_tutorial == 5 && instance_exists(objPlayer) && instance_exists(objItemTutorial)) {
    var item_final = instance_find(objItemTutorial, 0);
    if (item_final != noone && point_distance(objPlayer.x, objPlayer.y, item_final.x, item_final.y) < 32) {
        instance_destroy(item_final);
        texto_guia = "Parabéns!";
        if (alarm[0] == -1) {
            alarm[0] = game_get_speed(gamespeed_fps) * 3;
        }
    }
}

if (keyboard_check_pressed(ord("P")) && !exibir_popup && status_tutorial < 6) {
    exibir_popup = true;
}

if (keyboard_check(ord("Z")) || keyboard_check(ord("X"))) {
   if (forca_barra < 1) forca_barra += 1 / (game_get_speed(gamespeed_fps) * 2);
}

