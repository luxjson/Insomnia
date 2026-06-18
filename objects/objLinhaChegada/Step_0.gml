if (instance_exists(objNpcTutorial)) {
    var npc = instance_find(objNpcTutorial, 0);
    if (npc != noone && npc.tipo == "corredor" && npc.x >= x) {
        npc.velocidade_corrida = 0;
        var controle = instance_find(controllerTutorial, 0);
        if (controle != noone) {
            controle.texto_guia = "You lost! NPC won!";
            if (controle.alarm[2] == -1) controle.alarm[2] = 90;
        }
    }
}
if (instance_exists(objPlayer)) {
    if (objPlayer.x >= x) {
        var controle = instance_find(controllerTutorial, 0);
        if (controle != noone) {
            controle.fade_estado = "fade_out";
        }
        instance_destroy();
    }
}