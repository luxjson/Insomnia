timer++;
switch (state) {
    case 0:
        alpha = min(1, alpha + 0.02);
        if (alpha >= 1) {
            state = 1;
            timer = 0;
        }
        break;
    case 1:
        if (timer > 30) {
            state = 2;
            timer = 0;
        }
        break;
    case 2:
        text_alpha = min(1, text_alpha + 0.02);
        if (text_alpha >= 1) {
            state = 3;
            timer = 0;
        }
        break;
    case 3:
        if (timer > 60) {
            state = 4;
            timer = 0;
        }
        break;
    case 4:
        version_alpha = min(1, version_alpha + 0.02);
        credits_alpha = min(1, credits_alpha + 0.02);
        if (version_alpha >= 1) {
            state = 5;
            timer = 0;
        }
        break;
    case 5:
        if (timer > 60) {
            state = 6;
            timer = 0;
            var cx = display_get_gui_width() / 2;
            var cy = display_get_gui_height() / 2;
            for (var i = 0; i < 80; i++) {
                var ang = random(360);
                var spd = 2 + random(6);
                var px = cx + random(200) - 100;
                var py = cy + random(200) - 100;
                array_push(firework_particles, {
                    x: px,
                    y: py,
                    vx: lengthdir_x(spd, ang),
                    vy: lengthdir_y(spd, ang) - 2,
                    life: 60 + random(30),
                    alpha: 1,
                    size: 2 + random(3)
                });
            }
        }
        break;
    case 6:
        for (var i = array_length(firework_particles) - 1; i >= 0; i--) {
            var p = firework_particles[i];
            p.x += p.vx;
            p.y += p.vy;
            p.vy += 0.1;
            p.life--;
            p.alpha = p.life / 90;
            if (p.life <= 0) {
                array_delete(firework_particles, i, 1);
            }
        }
        if (array_length(firework_particles) == 0 && timer > 30) {
            state = 7;
            timer = 0;
        }
        break;
    case 7:
        text_alpha = max(0, text_alpha - 0.02);
        version_alpha = max(0, version_alpha - 0.02);
        credits_alpha = max(0, credits_alpha - 0.02);
        var cx = display_get_gui_width() / 2;
        var cy = display_get_gui_height() / 2;
        var cols = [c_red, c_orange, c_yellow, c_white];
        for (var i = 0; i < 30; i++) {
            var ang = random(360);
            var spd = 3 + random(7);
            var px = cx + random(40) - 20;
            var py = cy + random(40) - 20;
            var col_idx = irandom(array_length(cols) - 1);
            array_push(explosion_particles, {
                x: px,
                y: py,
                vx: lengthdir_x(spd, ang),
                vy: lengthdir_y(spd, ang) - 1,
                life: 40 + random(20),
                alpha: 1,
                size: 3 + random(5),
                color: cols[col_idx]
            });
        }
        if (text_alpha <= 0 && version_alpha <= 0 && credits_alpha <= 0) {
            state = 8;
            timer = 0;
        }
        break;
    case 8:
        for (var i = array_length(explosion_particles) - 1; i >= 0; i--) {
            var p = explosion_particles[i];
            p.x += p.vx;
            p.y += p.vy;
            p.vy += 0.2;
            p.life--;
            p.alpha = p.life / 60;
            if (p.life <= 0) {
                array_delete(explosion_particles, i, 1);
            }
        }
        if (array_length(explosion_particles) == 0) {
            room_goto(rm_AbbyBedroom);
            instance_destroy();
        }
        break;
}