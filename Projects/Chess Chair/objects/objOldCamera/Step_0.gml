var dw = display_get_width(), dh = display_get_height();
var ww = window_get_width(), wh = window_get_height();
if (window_get_fullscreen())
{
	surface_resize(application_surface, dw, dh);
}
else
{
	surface_resize(application_surface, ww, wh);
}