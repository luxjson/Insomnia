function ResetScene(stepNumber) {
    if (instance_exists(objNpcTutorial)) instance_destroy(objNpcTutorial);
    if (instance_exists(objCaixaTutorial)) instance_destroy(objCaixaTutorial);
    if (instance_exists(objItemTutorial)) instance_destroy(objItemTutorial);
    if (instance_exists(objInimigoTutorial)) instance_destroy(objInimigoTutorial);
    
    if (instance_exists(objPlayer)) {
        objPlayer.x = room_width / 2;
        objPlayer.y = room_height / 2;
        objPlayer.velocidade = 5;
    }
    
    var controle = instance_find(controllerTutorial, 0);
    if (controle != noone) {
        controle.status_tutorial = stepNumber;
        controle.forca_barra = 0; 
        controle.npcs_falados = 0;
        controle.itens_coletados = 0;
        controle.itens_removidos_count = 0;
        controle.inimigos_derrotados = 0;
		controle.dano_aplicado = 0;
        controle.caixas_encaixadas = 0; 
        
        var cx = room_width / 2;
        var cy = room_height / 2;
        
        var camada_id = (instance_exists(objPlayer)) ? objPlayer.layer : "Instances";
        
        switch(stepNumber) {
            case 1:
                controle.texto_guia = "Aperte E para falar com os NPCs imóveis.";
                instance_create_layer(cx - 150, cy - 150, camada_id, objNpcTutorial);
                instance_create_layer(cx + 150, cy - 150, camada_id, objNpcTutorial);
                instance_create_layer(cx - 200, cy + 100, camada_id, objNpcTutorial);
                instance_create_layer(cx + 200, cy + 100, camada_id, objNpcTutorial);
                instance_create_layer(cx,       cy - 220, camada_id, objNpcTutorial);
                break;
                
            case 2:
                controle.status_tutorial = 3;
                ResetScene(3); 
                break;
                
            case 3:
                controle.texto_guia = "Aperte I para o inventário. Pegue 5 itens com E. Para remover, arraste para fora da caixa.  Segure Z para empurrar caixas nos marcadores.";
                for (var i = 0; i < 5; i++) {
                    var it = instance_create_layer(cx + random_range(-250, 250), cy + random_range(-250, 250), camada_id, objItemTutorial);
                    it.coletavel = (i < 5); 
                }
                for (var i = 0; i < 3; i++) {
                    var box = instance_create_layer(cx - 150 + (i * 60), cy + 100, camada_id, objCaixaTutorial);
                    box.id_caixa = i;
                }
                break;
                
            case 4:
				if (controle.inventario_aberto = true) {
					controle.inventario_aberto = !controle.inventario_aberto;
				}
				controle.texto_guia = "Aperte X perto do inimigo. Segure para mais dano. Evite contato!";
                instance_create_layer(cx - 200, cy - 200, camada_id, objInimigoTutorial);
                instance_create_layer(cx + 200, cy - 200, camada_id, objInimigoTutorial);
                instance_create_layer(cx,       cy + 200, camada_id, objInimigoTutorial);
                break;
                
            case 5:
                controle.texto_guia = "DESAFIO FINAL: Pegue a medalha no centro da sala!";
                var medalha = instance_create_layer(cx, cy - 150, camada_id, objItemTutorial);
                medalha.coletavel = true;
                if (sprite_exists(spr_medalha)) {
                    medalha.sprite_index = spr_medalha;
                }
                break;
        }
    }
}