var controle = instance_find(controllerTutorial, 0);

if (controle != noone && !travada) {
    if (keyboard_check_released(ord("Z")) && distance_to_object(objPlayer) < 25) {
        
        var dir = point_direction(objPlayer.x, objPlayer.y, x, y);
        var distancia_pixels = lerp(16, 160, controle.forca_barra);
        
        x += lengthdir_x(distancia_pixels, dir);
        y += lengthdir_y(distancia_pixels, dir);
        controle.forca_barra = 0;
       
        if (x >= room_width / 2 + 200) {
            travada = true;
            x = room_width / 2 + 250;
            show_debug_message("Caixa encaixada com sucesso!");
        }
    }
}