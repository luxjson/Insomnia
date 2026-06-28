function key_to_string(key) {
    switch(key) {
        case vk_left: return "LEFT ARROW";
        case vk_right: return "RIGHT ARROW";
        case vk_up: return "UP ARROW";
        case vk_down: return "DOWN ARROW";
        case ord("Z"): return "Z";
        case ord("X"): return "X";
        default: return chr(key);
    }
}