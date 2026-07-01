var draw_color = c_white;
if (flash_timer > 0) {
    var flash = floor(current_time / 50) % 2;
    if (flash == 0) {
        draw_color = c_red;
    }
}
draw_sprite_ext(sprite_index, 0, x, y, 1, 1, 0, draw_color, 1);

var bar_w = 50;
var bar_h = 6;
var bar_x = x - bar_w / 2;
var bar_y = y - 30;
draw_set_color(c_black);
draw_rectangle(bar_x, bar_y, bar_x + bar_w, bar_y + bar_h, false);

var hp_pct = hp / max_hp;
var hp_color = c_lime;
if (hp_pct < 0.25) hp_color = c_red;
else if (hp_pct < 0.5) hp_color = c_yellow;
draw_set_color(hp_color);
draw_rectangle(bar_x + 2, bar_y + 2, bar_x + (bar_w - 4) * hp_pct, bar_y + bar_h - 2, false);