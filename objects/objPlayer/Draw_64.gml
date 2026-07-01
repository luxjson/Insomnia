if (!config_open && config_y <= -350) exit;

gpu_set_texfilter(false);

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var base_x = gui_w / 2;
var base_y = config_y + 20;

var box_x1 = 40;
var box_y1 = base_y;
var box_x2 = gui_w - 40;
var box_y2 = base_y + 450;

draw_set_color(c_black);
draw_rectangle(box_x1, box_y1, box_x2, box_y2, false);

draw_set_color(c_white);
draw_rectangle(box_x1, box_y1, box_x2, box_y2, true);
draw_set_color(c_white);
draw_line_width(box_x1, box_y1, box_x2, box_y1, 8);
draw_line_width(box_x1, box_y2, box_x2, box_y2, 8);
draw_line_width(box_x1, box_y1, box_x1, box_y2, 8);
draw_line_width(box_x2, box_y1, box_x2, box_y2, 8);

draw_set_font(global.fonteNormal);
draw_set_valign(fa_top);
draw_set_halign(fa_center);

var tabs = ["STATUS", "INVENTORY", "SETTINGS"];
var t_w = (gui_w - 80) / 3;
var tab_y = box_y1 + 25;

for(var i = 0; i < 3; i++) {
    if (config_tab == i) {
        draw_set_color(c_white);
        var tab_label = "* " + tabs[i] + " *";
    } else {
        draw_set_color(make_color_rgb(80, 80, 80));
        var tab_label = tabs[i];
    }
    draw_text(40 + (t_w * i) + (t_w / 2), tab_y, tab_label);
}

draw_set_color(make_color_rgb(60, 60, 60));
draw_line_width(60, tab_y + 45, gui_w - 60, tab_y + 45, 2);

var inner_y = tab_y + 65;

if (config_tab == 0) {
    var card_x = 80;
    var card_y = inner_y;
    
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    draw_text(card_x, card_y, "> " + string_upper("ABBY") + " <");
    
    draw_set_color(make_color_rgb(180, 180, 180));
    draw_text(card_x, card_y + 35, "HP");
    
    var hp_pct = hp_actual / hp_max;
    var hp_bars = string_repeat("=", floor(hp_pct * 20)) + string_repeat("-", 20 - floor(hp_pct * 20));
    draw_set_color(c_white);
    draw_text(card_x + 50, card_y + 35, hp_bars);
    
    draw_set_halign(fa_right);
    draw_set_color(c_white);
    draw_text(card_x + 413, card_y + 35, string(hp_actual) + "/" + string(hp_max));
    draw_set_halign(fa_left);
    
    draw_set_color(make_color_rgb(180, 180, 180));
    draw_text(card_x, card_y + 65, "ATK");
    draw_set_color(c_white);
    var atk_pct = clamp(stat_atk / 30, 0, 1);
    var atk_bars = string_repeat("=", floor(atk_pct * 20)) + string_repeat("-", 20 - floor(atk_pct * 20));
    draw_text(card_x + 50, card_y + 65, atk_bars);
    
    draw_set_halign(fa_right);
    draw_set_color(c_white);
    draw_text(card_x + 370, card_y + 65, string(stat_atk));
    draw_set_halign(fa_left);
    
    draw_set_color(make_color_rgb(180, 180, 180));
    draw_text(card_x, card_y + 95, "DEF");
    draw_set_color(c_white);
    var def_pct = clamp(stat_def / 30, 0, 1);
    var def_bars = string_repeat("=", floor(def_pct * 20)) + string_repeat("-", 20 - floor(def_pct * 20));
    draw_text(card_x + 50, card_y + 95, def_bars);
    
    draw_set_halign(fa_right);
    draw_set_color(c_white);
    draw_text(card_x + 370, card_y + 95, string(stat_def));
    draw_set_halign(fa_left);
    
    draw_set_color(make_color_rgb(80, 80, 80));
    draw_text(card_x, card_y + 125, "------------------------------");
    
    draw_set_color(make_color_rgb(180, 180, 180));
    draw_text(card_x, card_y + 155, "WEAPON");
    draw_set_color(c_white);
    draw_text(card_x + 100, card_y + 155, string(equipped_weapon));
    
    draw_set_color(make_color_rgb(180, 180, 180));
    draw_text(card_x, card_y + 185, "SHIELD");
    draw_set_color(c_white);
    draw_text(card_x + 100, card_y + 185, string(equipped_shield));
    
    if (sprite_exists(spr_idle)) {
        draw_sprite_part_ext(spr_idle, 0, 0, 0, frame_w, frame_h, gui_w - 200, card_y + 5, 5.5, 5.5, c_white, 1.0);
    }
}

if (config_tab == 1) {
    if (array_length(inventory) == 0) {
        draw_set_halign(fa_center);
        draw_set_color(make_color_rgb(80, 80, 80));
        draw_text(base_x, inner_y + 40, "--- INVENTORY IS EMPTY ---");
    } else {
        var item_spacing = 40;
        var max_items = floor((box_y2 - inner_y - 20) / item_spacing);
        var display_count = min(array_length(inventory), max_items);
        
        for(var i = 0; i < display_count; i++) {
            var eq_marker = "";
            if (inventory[i].type == "weapon" && equipped_weapon == inventory[i].name) eq_marker = " [E]";
            if (inventory[i].type == "shield" && equipped_shield == inventory[i].name) eq_marker = " [E]";
            
            draw_set_halign(fa_left);
            if (config_idx == i) {
                draw_set_color(c_white);
                var item_label = "* " + inventory[i].name + eq_marker;
            } else {
                draw_set_color(make_color_rgb(120, 120, 120));
                var item_label = "  " + inventory[i].name + eq_marker;
            }
            draw_text(100, inner_y + (i * item_spacing), item_label);
            
            draw_set_halign(fa_right);
            draw_set_color(make_color_rgb(100, 100, 100));
            draw_text(gui_w - 100, inner_y + (i * item_spacing), inventory[i].info);
        }
    }
}

if (config_tab == 2) {
    if (menu_sub_state == "main") {
        draw_set_halign(fa_center);
        var main_opts = ["OPTIONS", "CONTROLS", "GAME", "EXIT"];
        for(var i = 0; i < 4; i++) {
            if (config_idx == i) {
                draw_set_color(c_white);
                var lbl = "* " + main_opts[i] + " *";
            } else {
                draw_set_color(make_color_rgb(100, 100, 100));
                var lbl = main_opts[i];
            }
            draw_text(base_x, inner_y + (i * 40), lbl);
        }
    }
    
    if (menu_sub_state == "submenu_options") {
        draw_set_halign(fa_center);
        var opt_text = [
            "FULLSCREEN: " + (global.fullscreen ? "ON" : "OFF"),
            "BGM VOLUME: " + string(round(global.vol_bgm * 100)) + "%",
            "SFX VOLUME: " + string(round(global.vol_sfx * 100)) + "%",
            "BACK"
        ];
        for(var i = 0; i < 4; i++) {
            if (sub_menu_idx == i) {
                draw_set_color(c_white);
                var lbl = "* " + opt_text[i] + " *";
            } else {
                draw_set_color(make_color_rgb(100, 100, 100));
                var lbl = opt_text[i];
            }
            draw_text(base_x, inner_y + (i * 40), lbl);
        }
    }
    
    if (menu_sub_state == "submenu_controls") {
        draw_set_halign(fa_center);
        draw_set_color(c_white);
        draw_text(base_x, inner_y, "--- CONTROLS ---");
        draw_set_color(make_color_rgb(160, 160, 160));
        draw_text(base_x, inner_y + 40, "MOVE: ARROW KEYS");
		draw_text(base_x, inner_y + 80, "SPRINT: SHIFT");
        draw_text(base_x, inner_y + 120, "CONFIRM / ACTION: Z");
        draw_text(base_x, inner_y + 160, "CANCEL / BACK: X");
        draw_set_color(make_color_rgb(80, 80, 80));
        draw_text(base_x, inner_y + 220, "[ PRESS Z OR X TO RETURN ]");
    }
    
    if (menu_sub_state == "submenu_game") {
        draw_set_halign(fa_center);
        var game_opts = ["SAVE GAME", "LOAD GAME", "BACK"];
        for(var i = 0; i < 3; i++) {
            var fx = base_x;
            if (i == 1 && shake_continue > 0) fx += random_range(-shake_continue/4, shake_continue/4);
            
            if (i == 1 && error_flash_continue > 0) {
                draw_set_color(c_red);
            } else if (sub_menu_idx == i) {
                draw_set_color(c_white);
            } else {
                draw_set_color(make_color_rgb(100, 100, 100));
            }
            
            var lbl = sub_menu_idx == i ? "* " + game_opts[i] + " *" : game_opts[i];
            draw_text(fx, inner_y + (i * 40), lbl);
        }
    }
}

if (menu_sub_state == "submenu_save_confirm") {
    draw_set_color(c_black);
    draw_set_alpha(0.85);
    draw_rectangle(40, config_y + 10, gui_w - 40, config_y + 400, false);
    draw_set_alpha(1.0);
    
    var box_w = 500;
    var box_h = 220;
    var bx1 = base_x - (box_w / 2);
    var by1 = (gui_h / 2) - (box_h / 2) + config_y;
    var bx2 = base_x + (box_w / 2);
    var by2 = (gui_h / 2) + (box_h / 2) + config_y;
    
    draw_set_color(c_black);
    draw_rectangle(bx1, by1, bx2, by2, false);
    draw_set_color(c_white);
    draw_rectangle(bx1, by1, bx2, by2, true);
    draw_set_color(c_white);
    draw_line_width(bx1, by1, bx2, by1, 8);
    draw_line_width(bx1, by2, bx2, by2, 8);
    draw_line_width(bx1, by1, bx1, by2, 8);
    draw_line_width(bx2, by1, bx2, by2, 8);
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
    draw_text(base_x, by1 + 70, "* PROGRESS SAVED *");
    draw_set_color(make_color_rgb(160, 160, 160));
    draw_text(base_x, by1 + 120, "Z - OK");
    draw_text(base_x, by1 + 150, "X - CANCEL");
    draw_set_valign(fa_top);
}

if (menu_sub_state == "submenu_load_info") {
    draw_set_color(c_black);
    draw_set_alpha(0.85);
    draw_rectangle(40, config_y + 10, gui_w - 40, config_y + 400, false);
    draw_set_alpha(1.0);
    
    var box_w = 560;
    var box_h = 280;
    var bx1 = base_x - (box_w / 2);
    var by1 = (gui_h / 2) - (box_h / 2) + config_y;
    var bx2 = base_x + (box_w / 2);
    var by2 = (gui_h / 2) + (box_h / 2) + config_y;
    
    draw_set_color(c_black);
    draw_rectangle(bx1, by1, bx2, by2, false);
    draw_set_color(c_white);
    draw_rectangle(bx1, by1, bx2, by2, true);
    draw_set_color(c_white);
    draw_line_width(bx1, by1, bx2, by1, 8);
    draw_line_width(bx1, by2, bx2, by2, 8);
    draw_line_width(bx1, by1, bx1, by2, 8);
    draw_line_width(bx2, by1, bx2, by2, 8);
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    var ox = bx1 + 50;
    var oy = by1 + 45;
    
    draw_set_color(c_white);
    draw_text(ox, oy, "* LOAD GAME *");
    
    if (file_exists("save.json")) {
        var _f = file_text_open_read("save.json");
        var _json = file_text_read_string(_f);
        file_text_close(_f);
        var _data = json_parse(_json);
        
        draw_set_color(make_color_rgb(180, 180, 180));
        draw_text(ox, oy + 50, "NAME");
        draw_set_color(c_white);
        draw_text(ox + 100, oy + 50, "ABBY");
        
        draw_set_color(make_color_rgb(180, 180, 180));
        draw_text(ox, oy + 80, "HP");
        draw_set_color(c_white);
        draw_text(ox + 100, oy + 80, string(_data.hp) + "/" + string(_data.hp_max));
        
        draw_set_color(make_color_rgb(180, 180, 180));
        draw_text(ox, oy + 110, "ITEMS");
        draw_set_color(c_white);
        var inv_count = array_length(_data.inventory);
        draw_text(ox + 100, oy + 110, string(inv_count) + " ITEMS");
        
        draw_set_color(make_color_rgb(160, 160, 160));
        draw_text(base_x, by2 - 40, "Z - LOAD / X - CANCEL");
    } else {
        draw_set_color(make_color_rgb(80, 80, 80));
        draw_text(ox, oy + 50, "NO SAVE DATA FOUND");
        draw_set_color(make_color_rgb(160, 160, 160));
        draw_text(ox, oy + 90, "PRESS Z OR X TO RETURN");
    }
    draw_set_valign(fa_top);
}

for (var i = 0; i < array_length(shatter_particles); i++) {
    var p = shatter_particles[i];
    draw_set_color(c_red);
    draw_set_alpha(p.alpha);
    draw_rectangle(p.xx, p.yy + config_y, p.xx + choose(2,3), p.yy + config_y + choose(2,3), false);
}
draw_set_alpha(1.0);

if (menu_sub_state == "item_box") {
    draw_set_color(c_black);
    draw_set_alpha(0.85);
    draw_rectangle(40, config_y + 10, gui_w - 40, config_y + 400, false);
    draw_set_alpha(1.0);
    
    var box_w = 520;
    var box_h = 280;
    var bx1 = base_x - (box_w / 2);
    var by1 = (gui_h / 2) - (box_h / 2) + config_y;
    var bx2 = base_x + (box_w / 2);
    var by2 = (gui_h / 2) + (box_h / 2) + config_y;
    
    draw_set_color(c_black);
    draw_rectangle(bx1, by1, bx2, by2, false);
    draw_set_color(c_white);
    draw_rectangle(bx1, by1, bx2, by2, true);
    draw_set_color(c_white);
    draw_line_width(bx1, by1, bx2, by1, 6);
    draw_line_width(bx1, by2, bx2, by2, 6);
    draw_line_width(bx1, by1, bx1, by2, 6);
    draw_line_width(bx2, by1, bx2, by2, 6);
    
    var current_item = inventory[config_idx];
    
    if (sprite_exists(current_item.sprite)) {
        draw_sprite_ext(current_item.sprite, 0, bx1 + 80, by1 + (box_h / 2), 4, 4, 0, c_white, 1.0);
    }
    
    draw_set_halign(fa_left);
    var ox = bx1 + 200;
    var oy = by1 + 50;
    
    draw_set_color(c_white);
    draw_text(ox, oy, "* " + current_item.name + " *");
    draw_set_color(make_color_rgb(160, 160, 160));
    draw_text(ox, oy + 35, current_item.info);
    
    draw_set_color(make_color_rgb(80, 80, 80));
    draw_text(ox, oy + 65, "---------------------");
    
    var action_text = "EQUIP";
    if (current_item.type == "weapon" && equipped_weapon == current_item.name) action_text = "UNEQUIP";
    if (current_item.type == "shield" && equipped_shield == current_item.name) action_text = "UNEQUIP";
    
    var sub_opts = (current_item.type == "heal") ? ["USE", "DISCARD", "CANCEL"] : [action_text, "DISCARD", "CANCEL"];
    
    var opt_y = oy + 95;
    for(var i = 0; i < 3; i++) {
        if (box_selected_opt == i) {
            draw_set_color(c_white);
            var lbl = "* " + sub_opts[i] + " *";
        } else {
            draw_set_color(make_color_rgb(100, 100, 100));
            var lbl = sub_opts[i];
        }
        draw_text(ox, opt_y + (i * 40), lbl);
    }
}