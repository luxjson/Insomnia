if (variable_global_exists("load_data") && global.load_data != undefined) {
    var _data = global.load_data;
    
    if (variable_struct_exists(_data, "x")) x = _data.x;
    if (variable_struct_exists(_data, "y")) y = _data.y;
    if (variable_struct_exists(_data, "hp")) hp_actual = _data.hp;
    if (variable_struct_exists(_data, "hp_max")) hp_max = _data.hp_max;
    if (variable_struct_exists(_data, "atk")) stat_atk = _data.atk;
    if (variable_struct_exists(_data, "def")) stat_def = _data.def;
    if (variable_struct_exists(_data, "inventory")) inventory = _data.inventory;
    if (variable_struct_exists(_data, "equipped_weapon")) equipped_weapon = _data.equipped_weapon;
    if (variable_struct_exists(_data, "equipped_shield")) equipped_shield = _data.equipped_shield;
    
    if (variable_struct_exists(_data, "started_story") && instance_exists(objAbbyBedroom)) {
        objAbbyBedroom.started_story = _data.started_story;
    } else if (variable_struct_exists(_data, "started_story") && instance_exists(objAbbyBedroom)) {
		objCh0101.started_story = _data.started_story;
	}
    
    global.load_data = undefined;
}