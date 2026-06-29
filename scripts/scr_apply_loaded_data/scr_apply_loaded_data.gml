function scr_apply_loaded_data(_data) {
    if (instance_exists(objPlayer)) {
        objPlayer.x = _data.player_x;
        objPlayer.y = _data.player_y;
        objPlayer.hp = _data.player_hp;
        objPlayer.atk = _data.player_stats.atk;
        objPlayer.def = _data.player_stats.def;
        objPlayer.array_inventario = _data.inventory;
    }
}