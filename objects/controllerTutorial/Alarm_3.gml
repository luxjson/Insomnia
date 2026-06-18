if (instance_exists(objInimigoTutorial) == false && round_atual < 10) {
    round_atual++;
    SpawnEnemies(round_atual);
    texto_guia = "ROUND " + string(round_atual);
    mostrar_round = true;
    round_timer = 60;
    alarm[3] = 60;
}