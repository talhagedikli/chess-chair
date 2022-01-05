instance_destroy();
motion			= new Vector2(0);
motionDir		= point_direction(0, 0, motion.x, motion.y);
facing			= 1;
accel			= 0.3;
decel			= 0.5;
mSpeed			= 3;
grav			= 0.05;

jumping 		= false;
jPower			= 3;

upperVfxTimer	= new Timer();
ghostDashTimer	= new Timer();
blurTimer		= new Timer();
blurMagnitude	= 0;
blurMax			= 7;
IsMoving		= function()
{
	return bool(abs(sign(motion.x)));
}

OnGround		= function()
{
	return place_meeting(x, y+1, objBlock);
}

updateMotion	= function()
{
	var im = Control.Manager.Input;
	if (im.p.keyRight)
	{
		motion.x = approach(motion.x, mSpeed, accel);
	}
	else if (im.p.keyLeft)
	{
		motion.x = approach(motion.x, -mSpeed, accel);
	}
	else
	{
		motion.x = approach(motion.x, 0, decel);
	}
	if (motion.x =! 0)
	{
		facing	= sign(motion.x);
	}
	
	if (OnGround())
	{
		if (!jumping && im.p.keyJump)
		{
			motion.y = -jPower;
			jumping = true;
		}
	}
	else
	{
		jumping = false;
	}
	
	// var fx = layer_get_fx("fxBlurLayer");
	// fx_set_parameter(fx, "g_Radius", blurMagnitude);
}
updateDirection		= function()
{
	var i = Control.Manager.Input.p;
	if (i.keyLeft)
	{
		dirSpeed = approach(dirSpeed, dirSpeedMax, dirAccel);
	}
	else if (i.keyRight)
	{
		dirSpeed = approach(dirSpeed, -dirSpeedMax, dirAccel);
	}
	else
	{
		dirSpeed = approach(dirSpeed, 0, dirDecel);
	}
	dirSpeed	= clamp(dirSpeed, -dirSpeedMax, dirSpeedMax);
	dir			+= dirSpeed;
	dir			= ceil(dir);
	dir			= dir mod 361;
	log("dir: ", dir, " dirSpeed: ", dirSpeed, "x: ", x, "motion.x: ", motion.x); 
}
applyJump			= function()
{
	
}
applyDirection		= function()
{
	image_angle = dir;
	direction	= dir;		
}
applyMotion			= function()
{
	x	+= motion.x;
	y	+= motion.y;	
}

applyGravity		= function()
{
	if (!place_meeting(x, y + 1, objBlock))
	{
		motion.y += grav;
	}
}


state = new SnowState("move");
state.add("move", {
	enter: function()
	{
		var cm = Control.Manager.Cam;
		cm.following = self.id;
		ghostDashTimer.start(12, true);
	},
	step: function()
	{
		ghostDashTimer.on_timeout(function()
		{
			if (IsMoving())
			{
				//ghostDashTimer.reset();
			}
		});
		updateMotion();
		applyGravity();
		check_collisions_pixel_perfect(objBlock, motion);
	},
	leave: function()
	{
		
	}
});
state.add("dance", {
	enter: function()
	{
		
	},
	step: function()
	{
		
	},
	leave: function()
	{
		
	}
});

