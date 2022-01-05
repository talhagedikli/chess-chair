// in GMS1, set view_xview and view_yview instead
var xTo, yTo;
if (instance_exists(following))
{
	xTo = round(following.x) - (width / 2);
	yTo = round(following.y) - (height / 2);
}
else
{
	xTo = x;
	yTo = y;
}
x = lerp(x, xTo, 0.1);
y = lerp(y, yTo, 0.1);
__ApplyScreenShake();
camera.SetPos(floor(x), floor(y));
if (!surface_exists(surView)) {
    surView = surface_create(width + 1, height + 1);
}
view_surface_id[0] = surView;
