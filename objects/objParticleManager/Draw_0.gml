if (!surface_exists(surPS))
{
	var ws = window.getSize();
	surPS = surface_create(ws.x, ws.y);
}
else
{
	surface_set_target(surPS);
	part_system_drawit(global.PS);
	surface_reset_target();
}

