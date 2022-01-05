/// @description 
CheckRoom = function()
{
	if (state.get_current_state() != room_get_name(room))
	{
		state.change(room_get_name(room));
	}
}

Change = function(_room, _spawnerPos = new Vector2(0), _roomFunc = function() {})
{
	room_goto(_room);
	state.change(room_get_name(_room), _roomFunc);
}

state = new SnowState(room_get_name(rTitle));
state.add(room_get_name(rTitle), {	// ----------TITLE
	enter: function() 
	{
		if (!instance_exists(objTitleMenu)) instance_create_layer(x, y, layer, objTitleMenu);
	},
	step: function()
	{
	},
	leave: function() 
	{
	}
});
state.add(room_get_name(rWorld), {	// ----------WORLD
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


global.uiClock.add_cycle_method(function()
{
	state.step();
});


