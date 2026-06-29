function scr_save_game() {
    if (instance_exists(objPlayer)) {
        var _data = {
            room_name: room_get_name(room),
            x: objPlayer.x,
            y: objPlayer.y,
            hp: objPlayer.hp_actual,
            hp_max: objPlayer.hp_max,
            atk: objPlayer.stat_atk,
            def: objPlayer.stat_def,
            inventory: objPlayer.inventory,
            equipped_weapon: objPlayer.equipped_weapon,
            equipped_shield: objPlayer.equipped_shield
        };
        var _f = file_text_open_write("save.json");
        file_text_write_string(_f, json_stringify(_data));
        file_text_close(_f);
    }
}