if (message_timer > 0) message_timer--;

if (menu_dir_active) {
    if (keyboard_check_pressed(vk_up)) {
        menu_dir_index = (menu_dir_index + 3) % 4;
        audio_play_sound(move_sound, 1, false);
    }
    if (keyboard_check_pressed(vk_down)) {
        menu_dir_index = (menu_dir_index + 1) % 4;
        audio_play_sound(move_sound, 1, false);
    }
    if (keyboard_check_pressed(ord("Z"))) {
        var dir = menu_dir_index;
        var dr = 0, dc = 0;
        switch (dir) {
            case 0: dr = -1; break;
            case 1: dr = 1; break;
            case 2: dc = -1; break;
            case 3: dc = 1; break;
        }
        var nr = cursor_y + dr;
        var nc = cursor_x + dc;
        if (nr < 0 || nr > 3 || nc < 0 || nc > 3) {
            message = "Cannot move outside!";
            message_timer = 30;
            audio_play_sound(error_sound, 1, false);
        } else {
            var temp = grid[cursor_y][cursor_x];
            grid[cursor_y][cursor_x] = grid[nr][nc];
            grid[nr][nc] = temp;
            audio_play_sound(move_sound, 1, false);
            menu_dir_active = false;
        }
    }
    if (keyboard_check_pressed(ord("X"))) {
        menu_dir_active = false;
        audio_play_sound(move_sound, 1, false);
    }
    exit;
}

if (!focus_buttons) {
    if (keyboard_check_pressed(vk_up)) {
        cursor_y = max(0, cursor_y - 1);
        audio_play_sound(move_sound, 1, false);
    }
    if (keyboard_check_pressed(vk_down)) {
        if (cursor_y < 3) {
            cursor_y = min(3, cursor_y + 1);
            audio_play_sound(move_sound, 1, false);
        } else {
            focus_buttons = true;
            button_selected = 0;
            audio_play_sound(move_sound, 1, false);
        }
    }
    if (keyboard_check_pressed(vk_left)) {
        cursor_x = max(0, cursor_x - 1);
        audio_play_sound(move_sound, 1, false);
    }
    if (keyboard_check_pressed(vk_right)) {
        cursor_x = min(3, cursor_x + 1);
        audio_play_sound(move_sound, 1, false);
    }
    if (keyboard_check_pressed(ord("Z"))) {
        menu_dir_active = true;
        menu_dir_index = 0;
        audio_play_sound(move_sound, 1, false);
    }
} else {
    if (keyboard_check_pressed(vk_left)) {
        button_selected = max(0, button_selected - 1);
        audio_play_sound(move_sound, 1, false);
    }
    if (keyboard_check_pressed(vk_right)) {
        button_selected = min(1, button_selected + 1);
        audio_play_sound(move_sound, 1, false);
    }
    if (keyboard_check_pressed(vk_up)) {
        focus_buttons = false;
        audio_play_sound(move_sound, 1, false);
    }
    if (keyboard_check_pressed(ord("Z"))) {
        if (button_selected == 0) {
            for (var r = 0; r < 4; r++) {
                for (var c = 0; c < 4; c++) {
                    grid[r][c] = initial_grid[r][c];
                }
            }
            message = "Reset!";
            message_timer = 20;
            audio_play_sound(move_sound, 1, false);
        } else {
            var win = false;
            var correct = true;
            for (var r = 0; r < 4; r++) {
                for (var c = 0; c < 2; c++) {
                    if (grid[r][c] != 0) { correct = false; break; }
                }
                if (!correct) break;
            }
            if (correct) {
                for (var r = 0; r < 4; r++) {
                    for (var c = 2; c < 4; c++) {
                        if (grid[r][c] != 1) { correct = false; break; }
                    }
                    if (!correct) break;
                }
            }
            if (correct) win = true;
            if (!win) {
                correct = true;
                for (var r = 0; r < 4; r++) {
                    for (var c = 0; c < 2; c++) {
                        if (grid[r][c] != 1) { correct = false; break; }
                    }
                    if (!correct) break;
                }
                if (correct) {
                    for (var r = 0; r < 4; r++) {
                        for (var c = 2; c < 4; c++) {
                            if (grid[r][c] != 0) { correct = false; break; }
                        }
                        if (!correct) break;
                    }
                }
                if (correct) win = true;
            }
            if (win) {
                global.puzzle_solved = true;
                global.puzzle_active = false;
                with (instance_create_depth(puzzle_x - 220, puzzle_y, -100, objPortal)) {}
                with (objMinigame) { puzzle_solved = true; instance_destroy(); }
                instance_destroy();
            } else {
                message = "Not solved yet!";
                message_timer = 30;
                audio_play_sound(error_sound, 1, false);
            }
        }
    }
    if (keyboard_check_pressed(ord("X"))) {
        global.puzzle_active = false;
        instance_destroy();
    }
}