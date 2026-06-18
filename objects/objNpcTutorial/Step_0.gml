if (tipo == "corredor" && instance_exists(objLinhaChegada)) {
    var linha = instance_find(objLinhaChegada, 0);
    if (linha != noone && x < linha.x) x += velocidade_corrida;
}