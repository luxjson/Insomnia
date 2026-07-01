if (array_length(global.interact_queue) == 0 && !processing) {
    instance_destroy();
    exit;
}

if (!processing && array_length(global.interact_queue) > 0) {
    var data = global.interact_queue[0];
    title = data.title;
    text = data.text;
    color = data.color;
    processing = true;
    array_delete(global.interact_queue, 0, 1);
    
    dialogue("", text, 0.3, color, global.fonteNormal, -1);
}

if (processing && !instance_exists(objDialogue)) {
    processing = false;
    instance_destroy();
}