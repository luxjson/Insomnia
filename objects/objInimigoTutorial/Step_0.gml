
var controle = instance_find(controllerTutorial, 0);

if (controle != noone && instance_exists(objPlayer)) {
  
    var dir_player = point_direction(x, y, objPlayer.x, objPlayer.y);
    x += lengthdir_x(1.5, dir_player);
    y += lengthdir_y(1.5, dir_player);
   
    if (place_meeting(x, y, objPlayer)) {
        controle.player_hp -= 10;
        objPlayer.x += lengthdir_x(40, dir_player);
        objPlayer.y += lengthdir_y(40, dir_player);
        
        if (controle.player_hp <= 0) {
            controle.player_hp = 100;
            ResetScene(controle.status_tutorial); 
        }
    }
    
    if (keyboard_check_released(ord("X")) && distance_to_object(objPlayer) < 50) {
        
        var dano_sofrido = lerp(15, 50, controle.forca_barra);
        hp -= dano_sofrido;
        
        var dir_knockback = point_direction(objPlayer.x, objPlayer.y, x, y);
        x += lengthdir_x(50, dir_knockback);
        y += lengthdir_y(50, dir_knockback);

        controle.forca_barra = 0;
        
        if (hp <= 0) {
            controle.inimigos_derrotados++;
            instance_destroy();
           
            if (controle.status_tutorial == 4 && controle.inimigos_derrotados >= controle.total_inimigos_p4) {
                controle.fade_estado = "fade_out";
            }
        }
    }
}