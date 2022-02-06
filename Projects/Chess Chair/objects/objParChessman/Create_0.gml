// Variables
pos			= new Vector2(0);
selected	= false;

// Methods
/// @param {string} _mtoshow
function destroy(_mtoshow)
{
	instance_destroy(self.id);	
}
function clampPosition()
{
	pos.x = clamp(pos.x, 0, 7);	
	pos.y = clamp(pos.y, 0, 7);	
}
function getRealPosition(_vec)
{
	return new Vector2(objTestTable.bbox_top + _vec.y * DATA_VIEW.gridSize.y, objTestTable.bbox_left + _vec.x * DATA_VIEW.gridSize.x);
}

function updateRealPosition(_pos)
{
	var pp = objTestTable.getRealPosition(_pos);
	x	= pp.x;
	y	= pp.y;	
}

// States
fsm			= new StateMachine();
idleState	= new State("idle");
moveState	= new State("move");

