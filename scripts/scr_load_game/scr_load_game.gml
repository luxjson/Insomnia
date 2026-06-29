function scr_load_game(_fname) {
    if (file_exists(_fname)) {
        var _f = file_text_open_read(_fname);
        var _json = file_text_read_string(_f);
        file_text_close(_f);
        global.load_data = json_parse(_json);
        room_goto(asset_get_index(global.load_data.room_name));
    }
}