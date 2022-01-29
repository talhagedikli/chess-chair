log("-----------------------------------", "Game Started");
// Make sure i am created firs
if (instance_number(object_index) > 1)
{
	show("ERROR: MULTIPLE CONTROL OBJECT EXISTS");
	instance_destroy();
	exit;
}

Cm			= instance_create_layer(x, y, layer, objCamera);
Sl			= instance_create_layer(x, y, layer, objSaveManager);
In			= instance_create_layer(x, y, layer, objInputManager);
Pt			= instance_create_layer(x, y, layer, objParticleManager);
Fx			= instance_create_layer(x, y, layer, objFxManager);

// Methods
GameEnd = function()
{
	log("-----------------------------------", "Game Ended");
	game_end();
}

GameRestart = function()
{
	log("-----------------------------------", "Game Restarted");
	game_restart();
}






