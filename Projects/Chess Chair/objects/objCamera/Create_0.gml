application_surface_enable(false);
// viewWidth, viewHeight are your base resolution (ideally constants)
following = noone;

width	= GAME_RESOLUTION.x;
height	= GAME_RESOLUTION.y;
scale	= WINDOW_SCALE;
// in GMS1, set view_wview and view_hview instead
//camera_set_view_size(view, viewWidth, viewHeight);
//surface_resize(application_surface, viewWidth, viewHeight);
camera.SetSize(width + 1, height + 1);
window.SetSize(width * scale, height * scale);
gui.SetSize(width, height);
// Center window
alarm[0] = 1;
surView = -1;

//shake
shake			= false;
shakeTime		= 0;
shakeMagnitude	= 0;
shakeFade		= 0;
__ApplyScreenShake = function() 
{
	if (shake)
	{
		//reduce shake time by 1(every step)
		shakeTime -= 1;
			
		//calculate shake magnitude
		var _xval = random_range(-shakeMagnitude, shakeMagnitude); 
		var _yval = random_range(-shakeMagnitude, shakeMagnitude);
			
		//apply the shake
		x += _xval;
		y += _yval;
			
		if (shakeTime <= 0) 
		{
			//if shake time is zero, shake fade
			shakeMagnitude -= shakeFade; 

			if (shakeMagnitude <= 0) 
			{
				//if shake fade is zero, turn shake of
			    shake = false; 
			} 
		}
	}
}
Shake = function(_time, _magnitude, _fade = _magnitude)
{
	shakeTime		??= _time;
	shakeMagnitude	??= _magnitude;
	shakeFade		??= _fade;
	shake			= true;
}
Follow = function(_id = self.id)
{
	self.following = _id;
}

fsm			= new StateMachine();
normalState = new State("normal");
normalState.start = function()
{
	
}
normalState.step_end = function()
{
	var xTo, yTo;
	if (instance_exists(following))
	{
		xTo = round(following.x) - (width / 2);
		yTo = round(following.y) - (height / 2);
	}
	else
	{
		xTo = x;
		yTo = y;
	}
	x = lerp(x, xTo, 0.1);
	y = lerp(y, yTo, 0.1);
	self.__ApplyScreenShake();
	camera.SetPos(floor(x), floor(y));
	if (!surface_exists(surView)) {
	    surView = surface_create(width + 1, height + 1);
	}
	view_surface_id[0] = surView;	
}

fsm.Add(normalState);

fsm.Init("normal");