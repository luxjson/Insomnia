if (started_story && !alarm_triggered) {
    if (!instance_exists(objDialogue)) {
        alarm_triggered = true;
        alarm[0] = 5;
    }
}