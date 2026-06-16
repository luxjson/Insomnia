
var h_input = keyboard_check(vk_right) - keyboard_check(vk_left) + keyboard_check(ord("D")) - keyboard_check(ord("A"));
var v_input = keyboard_check(vk_down) - keyboard_check(vk_up) + keyboard_check(ord("S")) - keyboard_check(ord("W"));

if (h_input != 0 || v_input != 0) {
    var direcao = point_direction(0, 0, h_input, v_input);
    x += lengthdir_x(velocidade, direcao);
    y += lengthdir_y(velocidade, direcao);
}
var controle = instance_find(controllerTutorial, 0);
if (controle != noone) {
    
    if (keyboard_check(vk_lshift) && (controle.status_tutorial == 2 || controle.status_tutorial == 5)) {
        velocidade = 12;
    } else {
        velocidade = 5;
    }
    if (keyboard_check_pressed(ord("I")) && (controle.status_tutorial == 3 || controle.status_tutorial == 5)) {
        controle.inventario_aberto = !controle.inventario_aberto;
    }
    
    if (keyboard_check_pressed(ord("E"))) {
        
        var npc = instance_nearest(x, y, objNpcTutorial);
        if (npc != noone && distance_to_object(npc) < 40) {
            with (npc) {
                if (!ja_falou) {
                    ja_falou = true;
                    controle.npcs_falados++;
                    
                    if (controle.status_tutorial == 1 && controle.npcs_falados >= controle.total_npcs_p1) {
                        controle.fade_estado = "fade_out";
                    }
                }
            }
        }
        
        var item = instance_nearest(x, y, objItemTutorial);
        if (item != noone && distance_to_object(item) < 40 && item.coletavel) {
            if (controle.itens_coletados < 5) {
                controle.itens_coletados++;
                instance_destroy(item);
            }
        }
    }
}