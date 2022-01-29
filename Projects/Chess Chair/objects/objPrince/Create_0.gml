/// Variables
maxSpeedGround	= new Vector2(3);
maxSpeedWater	= new Vector2(3,5);
accel			= new Vector2(0.7);
decel			= new Vector2(1.6);
waterAccel		= new Vector2(0.07);
waterDecel		= new Vector2(0.05);
jPowerWater		= -0.3;
gSpeedWater		= 0.005;
gSpeed			= 0.16;
motion			= new Vector2(0);
onGround		= false;

// This will work on its own
waterFx = fx_create("_filter_underwater");
fx_set_single_layer(waterFx, true);

// Jump 
jPower			= -3;
jumps			= 0;
jumpsMax		= 2;
bufferCounter	= 0;
bufferMax		= 8;
coyoteCounter	= 0;
coyoteMax		= 6;
doubleJump		= true;
landed			= false;
canJump 		= false;

// Dash
dashTween		= new Tween(TweenType.QuartEaseIn, 0, 10, 20);

// Methods
checkCollisions = function(_object = objBlock, _motion = motion, _applyspd = true) 
{

	//I think this is better calculation for single mask
	var sprite_bbox_top		= sprite_get_bbox_top(self.sprite_index)	- sprite_get_yoffset(self.sprite_index);
	var sprite_bbox_bottom	= sprite_get_bbox_bottom(self.sprite_index)	- sprite_get_yoffset(self.sprite_index);
	var sprite_bbox_right	= sprite_get_bbox_right(self.sprite_index)	- sprite_get_xoffset(self.sprite_index);
	var sprite_bbox_left	= sprite_get_bbox_left(self.sprite_index)	- sprite_get_xoffset(self.sprite_index);

	//Applying horizontal speed if there is no collision with block
	if (_applyspd) x += _motion.x;
	//Horizontal collisions
	if place_meeting(x + sign(_motion.x), y, _object) {
		var wall = instance_place(x + sign(_motion.x), y, _object);
		if (_motion.x > 0)
		{ //right
			x = real((wall.bbox_left - 1) - sprite_bbox_right);
		} 
		else if (_motion.x < 0)
		{ //left
			x = real((wall.bbox_right + 1) - sprite_bbox_left);
		}
		_motion.x = 0;
	}

	//Applying vertical speed if there is no collision with block
	if (_applyspd) y += _motion.y;
	//Vertical collisions
	if place_meeting(x, y + sign(_motion.y), _object) {
		var wall = instance_place(x, y + sign(_motion.y), _object);
		if (_motion.y > 0)
		{ //down
			y = (wall.bbox_top - 1) - sprite_bbox_bottom;
		}
		else if (_motion.y < 0)
		{ //up
			y = (wall.bbox_bottom + 1) - sprite_bbox_top;
		}
		_motion.y = 0;
	}
}
checkOnGround	= function(_obj = objBlock) 
{
	return place_meeting(x, y+1, _obj);
}
clampMotion		= function(_speedVec)
{
	motion.x	= clamp(motion.x, -_speedVec.x, _speedVec.x);
	motion.y	= clamp(motion.y, -_speedVec.y, _speedVec.y);
}
checkInWater	= function()
{
	return place_meeting(x - sprite_width * 0.3, y - sprite_height * 0.3, objWater);
}
applyGravity	= function(_grav = self.gSpeed)
{
	if ( !onGround )
	{
		motion.y += _grav;
	}
}

// State Machine
fsm			= new StateMachine();
idleState	= new State("idle");
diveState	= new State("dive");
moveState	= new State("move");
dashState	= new State("dash");


// Move State
moveState.enter		= function()
{
}
moveState.step		= function()
{
	var in			= Control.In.p1;
	self.onGround	= self.checkOnGround(objBlock);
	if ( in.keyRight )
	{
		motion.x = approach(motion.x, self.maxSpeedGround.x, self.accel.x);
	}
	else if ( in.keyLeft )
	{
		motion.x = approach(motion.x, -self.maxSpeedGround.x, self.accel.x);	
	}
	else
	{
		motion.x = approach(motion.x, 0, self.decel.x);	
	}
	
	//Coyote time
	if (onGround == false)
	{
	    if (coyoteCounter > 0)
	    {
			coyoteCounter -= 1;
	    }
	}
	else
	{
	    self.coyoteCounter = self.coyoteMax;
	}
	if ( in.keyJump and self.canJump and self.coyoteCounter > 0 )
	{
	    motion.y += jPower;
	    canJump = false;
	}
	else if ( !in.keyJump and onGround )
	{
	    canJump = true;
	}
	//jump buffer
	if (in.keyJumpPressed)
	{
	    bufferCounter = bufferMax;
	}
	if (bufferCounter > 0)
	{
	    bufferCounter -= 1;
	    if (onGround == true)
	    {
		    bufferCounter = 0;
		    motion.y = jPower;
	    }
	}
	
	//double jump section
	if (jumps > 0 and in.keyJumpPressed and doubleJump)
	{
	    //reduce jumps variable by 1 every step
	    jumps -= 1;
	    motion.y = jPower;
	}
	else if (onGround == true)
	{
	    //set jumps variable to jumpsMax if it's on ground
	    jumps = jumpsMax;
	}
	//variable jump height
	if (onGround == false)
	{
	    if (motion.y < 0 and !in.keyJump)
	    {
		    //if InputManager.keySpace is not pressed, slow down by 50 percent
		    motion.y *= 0.7;
	    }
	}
	
	// Landed
	if (onGround == true)
	{
		if (landed == false)
		{
			landed = true;
		}
	}
	else
	{
	    landed = false;
	}	
	
	// Apply gravity
	self.applyGravity(gSpeed);
	if ( self.checkInWater() )
	{
		fsm.Change("dive");	
	}
	
	self.clampMotion(self.maxSpeedGround);
	self.checkCollisions(objBlock, self.motion, true);
}
moveState.leave		= function()
{
	
}

// Dive State
diveState.enter		= function()
{
	log("hey there, i am diving");
	motion.x = motion.x * 0.5;
	motion.y = motion.y * 0.5;
	layer_set_fx("Player", waterFx);
}
diveState.step		= function()
{
	var in = Control.In.p1;
	if ( in.keyRight )
	{
		motion.x = approach(motion.x, self.maxSpeedWater.x, self.waterAccel.x);
	}
	else if ( in.keyLeft )
	{
		motion.x = approach(motion.x, -self.maxSpeedWater.x, self.waterAccel.x);	
	}
	else
	{
		motion.x = approach(motion.x, 0, self.waterDecel.x);	
	}
	
	if ( in.keyUp )
	{
		motion.y = approach(motion.y, -self.maxSpeedWater.y, self.waterAccel.y);
	}
	else if ( in.keyDown )
	{
		motion.y = approach(motion.y, self.maxSpeedWater.y, self.waterAccel.y);	
	}

	
	if ( in.keyJump )
	{
	    motion.y += self.jPowerWater;
	}		
	
	self.applyGravity(self.gSpeedWater);
	self.clampMotion(self.maxSpeedWater)
	self.checkCollisions(objBlock, self.motion, true);
	if ( !self.checkInWater() )
	{
		fsm.Change("move");
		return;
	}
}
diveState.leave		= function()
{
	layer_clear_fx("Player");
}

// Dash State
dashState.enter		= function()
{
	
}
dashState.step		= function()
{
	
}
dashState.leave		= function()
{
	
}

// Fsm
fsm.Add(moveState);
fsm.Add(diveState);
fsm.Add(dashState);

fsm.Init("move");

// Execute
Control.Cm.Follow(self.id);







