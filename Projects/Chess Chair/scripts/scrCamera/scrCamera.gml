#macro view				view_camera[0]
#macro gui				global.__gui
#macro window			global.__window
#macro display			global.__display
#macro camera			global.__camera

#macro GAME_RESOLUTION	vec2(640, 360)
#macro GUI_RESOLUTION	vec2(1280, 720)
#macro WINDOW_SCALE		2

global.__camera = 
{
	width : camera_get_view_width(view),
	height : camera_get_view_height(view),
	x : camera_get_view_x(view), 
	y : camera_get_view_y(view),
	GetPos : function()
	{
		return vec2(camera_get_view_x(view), camera_get_view_y(view));
	},
	GetSize : function()
	{
		return vec2(camera_get_view_width(view), camera_get_view_height(view));
	},
	SetPos : function(_x, _y)
	{
		camera_set_view_pos(view, _x, _y);
		x = _x;
		y = _y;
	},
	SetSize : function(_w, _h)
	{
		camera_set_view_size(view, _w, _h);
		width = _w;
		height = _h;
	}
}
global.__gui = 
{
	width : display_get_gui_width(),
	height : display_get_gui_height(),
	center : vec2(display_get_gui_width() * 0.5, display_get_gui_height() * 0.5),
	GetCenter : function()
	{
		return vec2(display_get_gui_width() * 0.5, display_get_gui_height() * 0.5);	
	},
	GetSize : function()
	{
		return vec2(display_get_gui_width(), display_get_gui_height());
	},
	SetSize : function(_w = GUI_RESOLUTION.x, _h = GUI_RESOLUTION.y)
	{
		display_set_gui_size(_w, _h);
		width = _w;
		height = _h;
		center = vec2(width * 0.5, height * 0.5);
	},
	ResetSize : function(_w = GAME_RESOLUTION.x, _h = GAME_RESOLUTION.y)
	{
		display_set_gui_size(_w, _h);
		width = _w;
		height = _h;
		center = vec2(width * 0.5, height * 0.5);
	},
}
global.__window = 
{
	fullscreen : false,
	width : window_get_width(),
	height: window_get_height(),	
	center: vec2(window_get_width() * .5, window_get_height() * .5),
	GetCenter : function()
	{
		return vec2(window_get_width() * .5, window_get_height() * .5);
	},
	GetSize : function()
	{
		return vec2(window_get_width(), window_get_height());
	},
	SetSize : function(w, h, fs)
	{
		if ( argument_count > 2 ) { fullscreen = argument[2]; }
		var ww, hh;
		ww = w;
		hh = h;
		
		if ( fullscreen )
		{
			ww = display.width;
			hh = display.height;
		}
		
		window_set_size(ww,hh);
		width	= ww;
		height	= hh;
		center	= { x : ww*.5, y: hh*.5 };
		
		window_set_position(
			display.center.x - center.x,
			display.center.y - center.y
		);		
	}
}
global.__display = 
{
	width	: display_get_width(),
	height	: display_get_height(),
	center	: { x : display_get_width()*.5, y : display_get_height()*.5 },
	GetSize : function()
	{
		return vec2(display_get_width(), display_get_height());
	},
	GetCenter : function()
	{
		return vec2(display_get_width()*.5, display_get_height()*.5);
	}
}
function camera_shake(_time, _magnitude, _fade = _magnitude)
{
	/// @func Shake(time, magnitude, *fade)
	var co = Control.Cm.id;
	co.shakeTime		= _time;
	co.shakeMagnitude	= _magnitude;
	co.shakeFade		= _fade;
	co.shake			= true;
}