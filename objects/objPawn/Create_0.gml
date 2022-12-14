// Inherit the parent event
event_inherited();

pos = new Vector2(3, 4);

updateRealPosition(pos);

idleState.enter = function()
{
	show("entered idle");
}
idleState.step = function()
{
	var in = Core.in.p1;
	if (in.keyRightPressed)
	{
		pos.x = pos.x + 1;
		self.clampPosition();
		self.updateRealPosition(pos);
	}
	else if (in.keyLeftPressed)
	{
		pos.x = pos.x - 1;
		self.clampPosition();
		self.updateRealPosition(pos);
	}
		
	if (in.keyDownPressed)
	{
		pos.y = pos.y + 1;
		self.clampPosition();
		self.updateRealPosition(pos);
	}
	else if (in.keyUpPressed)
	{
		pos.y = pos.y - 1;
		self.clampPosition();
		self.updateRealPosition(pos);
	}
}
idleState.leave = function()
{
	show(" i am leaving idle");	
}
idleState.draw = function()
{
	draw_self();
	var pp = objTestTable.getRealPosition(new Vector2(0, 0));
	draw_rectangle_color(pp.x, pp.y, pp.x + DATA_VIEW.gridSize.x, pp.y + DATA_VIEW.gridSize.y, c_blue, c_green, c_blue, c_green, false);	
}


fsm.Add(idleState);
fsm.Init("idle");
