puzzle_x = 0;
puzzle_y = 0;

letters = ["A", "M"];
grid = [];
initial_grid = [];

var pieces = [];
for (var i = 0; i < 16; i++) {
    if (i < 8) array_push(pieces, 0);
    else array_push(pieces, 1);
}
for (var i = array_length(pieces) - 1; i > 0; i--) {
    var j = irandom(i);
    var swap = pieces[i];
    pieces[i] = pieces[j];
    pieces[j] = swap;
}
var idx = 0;
for (var r = 0; r < 4; r++) {
    grid[r] = [];
    initial_grid[r] = [];
    for (var c = 0; c < 4; c++) {
        grid[r][c] = pieces[idx];
        initial_grid[r][c] = pieces[idx];
        idx++;
    }
}

cursor_x = 0;
cursor_y = 0;
focus_buttons = false;
button_selected = 0;
menu_dir_active = false;
menu_dir_index = 0;
dir_options = ["UP", "DOWN", "LEFT", "RIGHT"];
message = "";
message_timer = 0;
move_sound = Beep;
error_sound = Beep;