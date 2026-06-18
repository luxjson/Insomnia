if (travada) {
    x = clamp(x, 0, room_width);
    y = clamp(y, 0, room_height);
} else {
    var marcador = noone;
    with (objMarcadorCaixa) {
        if (id_caixa == other.id_caixa && distance_to_object(other) < 5) {
            marcador = id;
            break;
        }
    }
    if (marcador != noone) {
        travada = true;
        x = marcador.x;
        y = marcador.y;
        var controle = instance_find(controllerTutorial, 0);
        if (controle != noone) {
            controle.caixas_encaixadas++;
            if (controle.caixas_encaixadas >= 3) {
                controle.fade_estado = "fade_out";
            }
        }
        instance_destroy(marcador);
    }
}