var controle = instance_find(controllerTutorial, 0);

if (controle != noone && instance_exists(objPlayer) && !controle.menu_aberto) {
    var dir_player = point_direction(x, y, objPlayer.x, objPlayer.y);
    x += lengthdir_x(1.5, dir_player);
    y += lengthdir_y(1.5, dir_player);
    
    if (place_meeting(x, y, objPlayer)) {
        controle.player_hp -= 10;
        objPlayer.x += lengthdir_x(40, dir_player);
        objPlayer.y += lengthdir_y(40, dir_player);
        
        if (controle.player_hp <= 0) {
            controle.player_hp = 100;
            room_restart();
        }
    }
}