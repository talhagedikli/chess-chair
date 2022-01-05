// Inherit the parent event
event_inherited();

pos = vec2(3, 4);

updateRealPosition(pos);

fsm.add("idle",
{
	enter: function()
	{
		
	},
	step: function()
	{
		var in = Control.In.p1;
		if (in.keyRightPressed)
		{
			pos.x = pos.x + 1;
			clampPosition();
			updateRealPosition(pos);
			
		}
		else if (in.keyLeftPressed)
		{
			pos.x = pos.x - 1;
			clampPosition();
			updateRealPosition(pos);
		}
		
		if (in.keyDownPressed)
		{
			pos.y = pos.y + 1;
			clampPosition();
			updateRealPosition(pos);
		}
		else if (in.keyUpPressed)
		{
			pos.y = pos.y - 1;
			clampPosition();
			updateRealPosition(pos);
		}
		//log("px: ", pos.x, "py: ", pos.y);
	}
})