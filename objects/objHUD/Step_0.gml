if (instance_exists(objDialogue)) exit;
if (objPlayer.config_open) exit;
if (global.puzzle_active) exit;
if (instance_exists(objSleepTrigger)) {
	if (objSleepTrigger.sleeping) exit;
}