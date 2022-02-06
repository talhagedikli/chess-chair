log("-----------------------------------", "Game Started");
// Make sure i am created firs
if (instance_number(self.object_index) > 1)
{
	show("ERROR: MULTIPLE CONTROL OBJECT EXISTS");
	instance_destroy();
	exit;
}

cm			= instance_create_layer(x, y, layer, objCamera);
sl			= instance_create_layer(x, y, layer, objSaveManager);
in			= instance_create_layer(x, y, layer, objInputManager);
pt			= instance_create_layer(x, y, layer, objParticleManager);
fx			= instance_create_layer(x, y, layer, objFxManager);

// Methods
function GameEnd()
{
	log("-----------------------------------", "Game Ended");
	game_end();
}

function GameRestart()
{
	log("-----------------------------------", "Game Restarted");
	game_restart();
}