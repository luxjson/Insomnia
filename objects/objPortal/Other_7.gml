if (state == "wakeup") {
    state = "idle";
    sprite_index = sprPortalIdle;
    image_speed = 0.15;
}
else if (state == "wakedown") {
    if (!transitioning) {
        start_transition();
    }
}