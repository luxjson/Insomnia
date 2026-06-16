if (status == 1) {
    if (logo_alpha < 1) logo_alpha += 0.05;
    
    if (progresso < 1) {
        progresso += 1 / tempo_carregamento;
    } else {
        progresso = 1;
        status = 2;
    }
}

if (status == 2) {
    if (logo_alpha > 0) logo_alpha -= 0.05;
    else status = 3;
}

if (status == 3) {
    if (menu_fade > 0) {
        menu_fade -= 0.04;
    } else {
        global.ja_viu_a_splash = true;
        instance_destroy();
    }
}