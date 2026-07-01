function key_to_string(_key) {
    switch (_key) {
        case vk_left: return "LEFT";
        case vk_right: return "RIGHT";
        case vk_up: return "UP";
        case vk_down: return "DOWN";
        case vk_shift: return "SHIFT";
        case vk_escape: return "ESCAPE";
        case vk_enter: return "ENTER";
        case vk_space: return "SPACE";
        case vk_control: return "CTRL";
        case vk_alt: return "ALT";
        case ord("Z"): return "Z";
        case ord("X"): return "X";
        case ord("C"): return "C";
        case ord("V"): return "V";
        case ord("A"): return "A";
        case ord("S"): return "S";
        case ord("D"): return "D";
        case ord("F"): return "F";
        case ord("Q"): return "Q";
        case ord("W"): return "W";
        case ord("E"): return "E";
        case ord("R"): return "R";
        default: return string(chr(_key));
    }
}