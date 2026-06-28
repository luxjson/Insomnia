if (menu_input_delay > 0) menu_input_delay--;
var sfx_vol = variable_global_exists("vol_sfx") ? global.vol_sfx : 1.0;

var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
for (var i = 0; i < star_count; i++) {
    star_list[i].yy += star_list[i].spd;
    if (star_list[i].yy > gui_h) {
        star_list[i].yy = -10;
        star_list[i].xx = random(gui_w);
    }
}

if (game_state == MINIGAME_STATE.INTRO) {
    if (!show_choice_menu) {
        switch (text_state) {
            case 0: text_alpha += text_fade_speed; if (text_alpha >= 1) { text_alpha = 1; text_state = 1; text_timer = 0; } break;
            case 1: text_timer++; if (text_timer >= text_duration || keyboard_check_pressed(ord("Z"))) text_state = 2; break;
            case 2: text_alpha -= text_fade_speed; if (text_alpha <= 0) { text_alpha = 0; current_text_index++; if (current_text_index >= array_length(dev_texts)) show_choice_menu = true; else text_state = 0; } break;
        }
    } else {
        if (keyboard_check_pressed(vk_up)) { choice_index = 0; var s = audio_play_sound(snd_select, 1, false); audio_sound_gain(s, sfx_vol, 0); }
        if (keyboard_check_pressed(vk_down)) { choice_index = 1; var s = audio_play_sound(snd_select, 1, false); audio_sound_gain(s, sfx_vol, 0); }
        if (keyboard_check_pressed(ord("Z")) && menu_input_delay == 0) {
            var s = audio_play_sound(snd_beep, 1, false); audio_sound_gain(s, sfx_vol, 0);
            if (choice_index == 0) {
                game_state = MINIGAME_STATE.PLAYING;
                score_points = 0;
                player_lives = 5;
                player_x = display_get_gui_width() / 2;
                player_last_x = player_x;
                player_lasers = []; enemies = []; enemy_lasers = [];
            } else {
                game_end();
            }
        }
    }
}

if (game_state == MINIGAME_STATE.PLAYING) {
    player_last_x = player_x;

    if (keyboard_check(vk_left))  player_x = max(40, player_x - player_speed);
    if (keyboard_check(vk_right)) player_x = min(gui_w - 40, player_x + player_speed);
    
    if (player_cooldown > 0) player_cooldown--;
    if (keyboard_check(ord("Z")) && player_cooldown == 0) {
        var s = audio_play_sound(snd_beep, 1, false); audio_sound_gain(s, sfx_vol * 0.4, 0);
        array_push(player_lasers, { xx: player_x, yy: player_y - 15, spd: 10 });
        player_cooldown = 10; 
    }

    for (var i = array_length(player_lasers) - 1; i >= 0; i--) {
        player_lasers[i].yy -= player_lasers[i].spd;
        if (player_lasers[i].yy < 0) array_delete(player_lasers, i, 1);
    }
    
    enemy_spawn_timer++;
    if (enemy_spawn_timer >= 50) {
        array_push(enemies, {
            xx: random_range(60, gui_w - 60),
            yy: -20,
            spd: random_range(1.0, 2.0),
            shoot_chance: random(100),
            pulse: random(10), 
            radius: 12
        });
        enemy_spawn_timer = 0;
    }
    
    var count_enemy_lasers = array_length(enemy_lasers);
    for (var i = array_length(enemies) - 1; i >= 0; i--) {
        var e = enemies[i];
        e.yy += e.spd;
        e.pulse += 0.2; 
       
        if (e.shoot_chance > 99.5 && count_enemy_lasers < 2) { 
            array_push(enemy_lasers, { xx: e.xx, yy: e.yy + 10, spd: 3.5 });
            e.shoot_chance = 0; 
        }
        
        if (e.yy > gui_h) {
            player_lives--;
            array_delete(enemies, i, 1);
            if (player_lives <= 0) game_state = MINIGAME_STATE.GAMEOVER;
            continue;
        }
        
        for (var j = array_length(player_lasers) - 1; j >= 0; j--) {
            var l = player_lasers[j];
            if (point_distance(l.xx, l.yy, e.xx, e.yy) < e.radius + 6) {
                score_points += 50;
                array_delete(enemies, i, 1);
                array_delete(player_lasers, j, 1);
					if (score_points >= 1000) {
					    game_state = MINIGAME_STATE.VICTORY;
					    menu_input_delay = 60;
					    end_menu_index = 0;
					    if (!audio_is_playing(snd_victory)) {
					        var som_vic = audio_play_sound(snd_victory, 10, false);
					        audio_sound_gain(som_vic, sfx_vol, 0); 
					    }
					}
                break;
            }
        }
    }
    
    for (var i = array_length(enemy_lasers) - 1; i >= 0; i--) {
        var el = enemy_lasers[i];
        el.yy += el.spd;
        
        if (el.yy > gui_h) { array_delete(enemy_lasers, i, 1); continue; }
        
        if (point_distance(el.xx, el.yy, player_x, player_y) < 18) {
            player_lives--;
            array_delete(enemy_lasers, i, 1);
            if (player_lives <= 0) { game_state = MINIGAME_STATE.GAMEOVER; end_menu_index = 0; }
        }
    }
}

if (game_state == MINIGAME_STATE.GAMEOVER) {
    if (keyboard_check_pressed(vk_up)) { end_menu_index = 0; var s = audio_play_sound(snd_select, 1, false); audio_sound_gain(s, sfx_vol, 0); }
    if (keyboard_check_pressed(vk_down)) { end_menu_index = 1; var s = audio_play_sound(snd_select, 1, false); audio_sound_gain(s, sfx_vol, 0); }

    if (keyboard_check_pressed(ord("Z")) && menu_input_delay == 0) {
        var s = audio_play_sound(snd_beep, 1, false); audio_sound_gain(s, sfx_vol, 0);
        if (end_menu_index == 0) { 
            score_points = 0; player_lives = 5; player_x = display_get_gui_width() / 2; player_last_x = player_x;
            player_lasers = []; enemies = []; enemy_lasers = [];
            game_state = MINIGAME_STATE.PLAYING;
        } else {
            game_end();
        }
    }
}

if (game_state == MINIGAME_STATE.VICTORY) {
    
    if (keyboard_check_pressed(vk_up)) { end_menu_index = 0; var s = audio_play_sound(snd_select, 1, false); audio_sound_gain(s, sfx_vol, 0); }
    if (keyboard_check_pressed(vk_down)) { end_menu_index = 1; var s = audio_play_sound(snd_select, 1, false); audio_sound_gain(s, sfx_vol, 0); }
    
    if (keyboard_check_pressed(ord("Z")) && menu_input_delay == 0) {
        var s = audio_play_sound(snd_beep, 1, false); audio_sound_gain(s, sfx_vol, 0);
        if (end_menu_index == 0) {
            var base_tweet = "I just scored " + string(score_points) + " points on the @SomiariGames development minigame! The light always finds a way.";
            var twitter_url = "https://twitter.com/intent/tweet?text=" + url_encode(base_tweet);
            url_open(twitter_url); 
        } else {
            game_end();
        }
    }
}