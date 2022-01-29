// Variables
pos			= new Vector2(0);
selected	= false;

// Methods
/// @param {string} _mtoshow
destroy = function(_mtoshow)
{
	instance_destroy(self.id);	
}
clampPosition = function()
{
	pos.x = clamp(pos.x, 0, 7);	
	pos.y = clamp(pos.y, 0, 7);	
}
getRealPosition = function(_vec)
{
	return new Vector2(objTestTable.bbox_top + _vec.y * GRID_HEIGHT, objTestTable.bbox_left + _vec.x * GRID_WIDTH);
}

updateRealPosition = function(_pos)
{
	var pp = objTestTable.getRealPosition(_pos);
	x	= pp.x;
	y	= pp.y;	
}

// States
fsm			= new StateMachine();
idleState	= new State("idle");
moveState	= new State("move");

