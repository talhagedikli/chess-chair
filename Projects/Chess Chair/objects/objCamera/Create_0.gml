#region INITIALIZATION
application_surface_enable(false);
// viewWidth, viewHeight are your base resolution (ideally constants)
following = noone;

width	= DATA_VIEW.gameResolution.x;
height	= DATA_VIEW.gameResolution.y;
scale	= DATA_VIEW.windowScale;
//camera_set_view_size(VIEW, viewWidth, viewHeight);
//surface_resize(application_surface, viewWidth, viewHeight);
camera.setSize(width + 1, height + 1);
window.setSize(width * scale, height * scale);
gui.setSize(width, height);

// Center window
alarm[0] = 1;
surView = -1;

// Screenshake
shake			= false;
shakeTime		= 0;
shakeMagnitude	= 0;
shakeFade		= 0;
#endregion

#region STATE MACHINE
fsm			= new StateMachine();
normalState = new State("normal");
normalState.start = function()
{
	
}
normalState.step_end = function()
{
	var xTo, yTo;
	if (instance_exists(self.following))
	{
		xTo = round(following.x) - (self.width / 2);
		yTo = round(following.y) - (self.height / 2);
	}
	else
	{
		xTo = x;
		yTo = y;
	}
	x = lerp(x, xTo, 0.1);
	y = lerp(y, yTo, 0.1);
	ApplyScreenShake();
	camera.setPosition(floor(x), floor(y));
	if (!surface_exists(self.surView)) {
	    surView = surface_create(width + 1, height + 1);
	}
	view_surface_id[0] = surView;	
}

fsm.Add(normalState);
fsm.Init("normal");
#endregion

#region METHODS
function ApplyScreenShake() 
{
	if (self.shake)
	{
		//reduce shake time by 1(every step)
		other.shakeTime -= 1;
			
		//calculate shake magnitude
		var _xval = random_range(-self.shakeMagnitude, self.shakeMagnitude); 
		var _yval = random_range(-self.shakeMagnitude, self.shakeMagnitude);
			
		//apply the shake
		x += _xval;
		y += _yval;
			
		if (self.shakeTime <= 0) 
		{
			//if shake time is zero, shake fade
			other.shakeMagnitude -= other.shakeFade; 

			if (shakeMagnitude <= 0) 
			{
				//if shake fade is zero, turn shake of
			    shake = false; 
			} 
		}
	}
}
/// @param {real} _time
/// @param {real} _magnitude
/// @param {real} _fade
function Shake(_time, _magnitude, _fade = _magnitude)
{
	shakeTime		= _time;
	shakeMagnitude	= _magnitude;
	shakeFade		= _fade;
	shake			= true;
}
/// @param {ID.Instance} _id
function Follow(_id)
{
	following = _id;
}
#endregion