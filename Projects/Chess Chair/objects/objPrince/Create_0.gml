#region VARIABLES
maxSpeedGround = new Vector2(4);
maxSpeedWater = new Vector2(3, 6);
accel = new Vector2(0.7);
decel = new Vector2(1.6);
waterAccel = new Vector2(0.07);
waterDecel = new Vector2(0.05);
jPowerWater = -0.3;
gSpeedWater = 0.005;
gSpeed = 0.16;
motion = new Vector2(0);
onGround = false;

// Jump 
jPower = -3.0;
jumps = 0.0;
jumpsMax = 2.0;
bufferCounter = 0.0;
bufferMax = 8.0;
coyoteCounter = 0.0;
coyoteMax = 6.0;
doubleJump = true;
landed = false;
canJump = false;

dashDur = 20;
dashPower = 10;
dashTween = new Tween(TweenType.QuartEaseIn, dashDur, 0, dashPower);

// This will work on its own
waterFx = fx_create("_filter_underwater");
fx_set_single_layer(waterFx, true);
#endregion

#region STATE MACHINE
fsm = new StateMachine();
idleState = new State("idle");
diveState = new State("dive");
moveState = new State("move");
dashState = new State("dash");

Core.cm.Follow(self.id);

// Move State
moveState.enter = function() {

}
moveState.step = function()
{
    var in = Core.in.p1;
    onGround = checkOnGround(objBlock);
    if ( in .keyRight)
    {
        motion.x = approach(motion.x, maxSpeedGround.x, accel.x);
    }
    else if ( in .keyLeft)
    {
        motion.x = approach(motion.x, -maxSpeedGround.x, accel.x);
    }
    else
    {
        motion.x = approach(motion.x, 0, decel.x);
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
        coyoteCounter = coyoteMax;
    }
    if ( in .keyJump and canJump and coyoteCounter > 0)
    {
        motion.y += jPower;
        canJump = false;
    }
    else if (! in .keyJump and onGround)
    {
        canJump = true;
    }
    //jump buffer
    if ( in .keyJumpPressed)
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
    if (jumps > 0 and in .keyJumpPressed and doubleJump)
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
        if (motion.y < 0 and! in .keyJump)
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
    applyGravity(gSpeed);
    if (checkInWater())
    {
        fsm.Change("dive");
    }

    clampMotion(maxSpeedGround);
    checkCollisions(objBlock, motion, true);
}
moveState.leave = function() {

}

// Dive State
diveState.enter = function()
{
    log("hey there, i am diving");
    motion.x = motion.x * 0.5;
    motion.y = motion.y * 0.5;
    layer_set_fx("Player", self.waterFx);
}
diveState.step = function()
{
    var in = Core.in.p1;
    if ( in .keyRight)
    {
        motion.x = approach(motion.x, maxSpeedWater.x, waterAccel.x);
    }
    else if ( in .keyLeft)
    {
        motion.x = approach(motion.x, -maxSpeedWater.x, waterAccel.x);
    }
    else
    {
        motion.x = approach(motion.x, 0, waterDecel.x);
    }

    if ( in .keyUp)
    {
        motion.y = approach(motion.y, -maxSpeedWater.y, waterAccel.y);
    }
    else if ( in .keyDown)
    {
        motion.y = approach(motion.y, maxSpeedWater.y, waterAccel.y);
    }


    if ( in .keyJump)
    {
        motion.y += jPowerWater;
    }
    applyGravity(gSpeedWater);
    clampMotion(maxSpeedWater)
    checkCollisions(objBlock, motion, true);
    if (!checkInWater())
    {
        fsm.Change("move");
        return;
    }
}
diveState.leave = function()
{
    layer_clear_fx("Player");
}

// Dash State
dashState.enter = function() {}
dashState.step = function() {

}
dashState.leave = function() {

}

// Fsm
fsm.Add(moveState);
fsm.Add(diveState);
fsm.Add(dashState);

fsm.Init("move");
#endregion

#region METHODS
/// @param {Resource.GMObject}	[_object=objBlock]
/// @param {Struct.Vector2}		[_motion=motion]
/// @param {bool}				[_applyspd=true]
function checkCollisions(_object, _motion, _applyspd = true)
{
    //I think this is better calculation for single mask
    var sprite_bbox_top = sprite_get_bbox_top(self.sprite_index) - sprite_get_yoffset(self.sprite_index);
    var sprite_bbox_bottom = sprite_get_bbox_bottom(self.sprite_index) - sprite_get_yoffset(self.sprite_index);
    var sprite_bbox_right = sprite_get_bbox_right(self.sprite_index) - sprite_get_xoffset(self.sprite_index);
    var sprite_bbox_left = sprite_get_bbox_left(self.sprite_index) - sprite_get_xoffset(self.sprite_index);

    //Applying horizontal speed if there is no collision with block
    if (_applyspd) x += _motion.x;
    //Horizontal collisions
    if place_meeting(x + sign(_motion.x), y, _object)
    {
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
    if place_meeting(x, y + sign(_motion.y), _object)
    {
        var wall = instance_place(x, y + sign(_motion.y), _object);
        if (_motion.y > 0)
        { //down
            y = real((wall.bbox_top - 1) - sprite_bbox_bottom);
        }
        else if (_motion.y < 0)
        { //up
            y = real((wall.bbox_bottom + 1) - sprite_bbox_top);
        }
        _motion.y = 0;
    }
}
/// @param {Resource.GMObject} [_obj=objBlock]
function checkOnGround(_obj)
{
    return place_meeting(x, y + 1, _obj);
}
/// @param {Struct.Vector2} _speedVec
function clampMotion(_speedVec)
{
    motion.x = clamp(motion.x, -_speedVec.x, _speedVec.x);
    motion.y = clamp(motion.y, -_speedVec.y, _speedVec.y);
}
/// No argumments
function checkInWater()
{
    return place_meeting(x - sprite_width * 0.3, y - sprite_height * 0.3, objWater);
}
/// @param {real} _graw
function applyGravity(_grav)
{
    if (!onGround)
    {
        motion.y += _grav;
    }
}
#endregion
