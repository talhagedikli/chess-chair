states		= {
	idle: "idle",
	move: "move"
}
pos			= vec2(0);
selected	= false;

// Methods
destroy = function()
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
	return vec2(objTestTable.bbox_top + _vec.y * GRID_HEIGHT, objTestTable.bbox_left + _vec.x * GRID_WIDTH);
}
updateRealPosition = function(_pos)
{
	var pp = objTestTable.getRealPosition(_pos);
	x	= pp.x;
	y	= pp.y;	
}

fsm = new SnowState("idle");


