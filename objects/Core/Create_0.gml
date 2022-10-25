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
lwo			= instance_create_layer(x, y, layer, objLwoManager);



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

// Create Event
/*
Arguments:
Animation Curve:		Curve's asset
Channel:				Name(string) or index
Speed:					Evalution speed per frame
Loop:					To loop when it finishes)	-> default=false
Autostart:				Whether you want to start it automaticly or manually -> default=false
Autorun:				Whether you want to evaluete the value via "run" method or let the control object to run -> default=false

Methods:
getValue():				Returns the evaluated value
run():					Runs the curve manually ( use it if you set the "_autorun" argument to false
reset():				Resets the channel and value
start():				Starts to run automaticly
stop():					Stops to evaluate the channel
onTimeout(function):	function to run on done 
/*