yy += vy;
vy *= 0.9;
duration--;
alpha = duration / 30;
if (duration <= 0) instance_destroy();