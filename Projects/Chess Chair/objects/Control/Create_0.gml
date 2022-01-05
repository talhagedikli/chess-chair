#macro GRID_WIDTH 32
#macro GRID_HEIGHT 32
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


//#macro manager				global.__managers
//global.__managers = 
//{
//	cam			: instance_create_layer(x, y, layer, objSmoothCamera),
//	saveload	: instance_create_layer(x, y, layer, objSaveManager),
//	input		: instance_create_layer(x, y, layer, objInputManager),
//	part		: instance_create_layer(x, y, layer, objParticleManager)
//}

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







