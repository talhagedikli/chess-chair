//width and height 480*270
defWidth		=	1920/3;
defHeight		=	1080/3;
windowScale		=	2;

view			= 
{
	width	: 1920/3,
	height	: 1080/3,
	scale	: 2,
	x		: x,
	y		: y
}
following		= noone;

Follow = function(_id = self.id)
{
	following = _id;
}


//spd variables
followSpd		= 0.1;

//cam width and height
viewWidth		= defWidth;
viewHeight		= defHeight;

//first set to default
camW = viewWidth;
camH = viewHeight;

view.x = 0;
view.y = 0;


//set window size
window_set_size(view.width * view.scale, view.height * view.scale);
alarm[0] = 1;

//re-set surface and gui 
surface_resize(application_surface, view.width * view.scale, view.height * view.scale);
display_set_gui_size(viewWidth * view.scale, viewHeight * view.scale);



//shake
shake			= false;
shake_time		= 0;
shake_magnitude = 0;
shake_fade		= 0;

ApplyScreenShake = function () 
{
	if (shake)
	{
		//reduce shake time by 1(every step)
		shake_time -= 1;
			
		//calculate shake magnitude
		var _xval = random_range(-shake_magnitude, shake_magnitude); 
		var _yval = random_range(-shake_magnitude, shake_magnitude);
			
		//apply the shake
		view.x += _xval;
		view.y += _yval;
			
		if (shake_time <= 0) 
		{
			//if shake time is zero, shake fade
			shake_magnitude -= shake_fade; 

			if (shake_magnitude <= 0) 
			{
				//if shake fade is zero, turn shake of
			    shake = false; 
			} 
		}
	}
	
}

state = new SnowState("normal");
state.add("normal", {
	step: function()
	{
		var xTo, yTo;
		if (instance_exists(following))
		{
			xTo = round(following.x) - (view.width / 2);
			yTo = round(following.y) - (view.height / 2);
		}
		else
		{
			xTo = x;
			yTo = y;
		}
		
		//view.x = abs(difX) < EPSILON ? targetX : lerp(view.x, targetX, followSpd);
		// view.x = 0;
		// view.y = 0;
		view.x = flerp(view.x, xTo, followSpd);
		view.y = flerp(view.y, yTo, followSpd);
		//view.y = abs(difY) < EPSILON ? targetY : lerp(view.y, targetY, followSpd);
		ApplyScreenShake();
		view.x = clamp(view.x, -shake_magnitude, room_width - view.width + shake_magnitude);
		view.y = clamp(view.y, -shake_magnitude, room_height - view.height + shake_magnitude);		
	}
});
