#macro DATA_VIEW		__data_view()
#macro VIEW				view_camera[0]


#macro gui				__GuiInstance()
#macro window			__WindowInstance()
#macro display			__DisplayInstance()
#macro camera			__CameraInstance()



function __data_view()
{
	static data =
	{
		gameResolution:		new Vector2(640, 360),
		guiResolution:		new Vector2(1280, 720),
		gridSize:			new Vector2(32),
		windowScale:		2
	}
	return data;
}


function __Camera() constructor
{
	static size = function()
	{
		return new Vector2(camera_get_view_width(VIEW), camera_get_view_height(VIEW));	
	}
	
	static position = function()
	{
		return new Vector2(camera_get_view_x(VIEW), camera_get_view_y(VIEW));	
	}
	
	static setPosition = function(_x, _y)
	{
		camera_set_view_pos(VIEW, _x, _y);
	}
	
	static setSize = function(_w, _h)
	{
		camera_set_view_size(VIEW, _w, _h);
	}
}

function __CameraInstance()
{
	static instance = new __Camera();
	return instance;
}

function __Gui() constructor
{
	static getSize = function()
	{
		return new Vector2(display_get_gui_width(), display_get_gui_height());	
	}
	
	static getCenter = function()
	{
		return new Vector2(display_get_gui_width() * 0.5, display_get_gui_height() * 0.5);
	}
	
	static setSize = function(_w, _h)
	{
		display_set_gui_size(_w, _h);
	}
	
	static resetSize = function()
	{
		display_set_gui_size(DATA_VIEW.guiResolution.x, DATA_VIEW.guiResolution.y);
	}
}

function __GuiInstance()
{
	static instance = new __Gui();
	return instance;
}

function __Display() constructor
{
	fullscreen = false;
	
	static getSize = function()
	{
		return new Vector2(display_get_width(), display_get_height());
	}
	
	static getCenter = function()
	{
		return new Vector2(display_get_width()*.5, display_get_height()*.5);
	}
	
}

function __DisplayInstance()
{
	static instance = new __Display();
	return instance;
}

function __Window() constructor
{
	fullscreen = false;
	
	static getSize = function()
	{
		return new Vector2(window_get_width(), window_get_height());
	}
	
	static getCenter = function()
	{
		return new Vector2(window_get_width() * .5, window_get_height() * .5);
	}
	
	static setSize = function(_w, _h)
	{
		if ( argument_count > 2 ) { fullscreen = argument[2]; }
		var ww, hh;
		ww = _w;
		hh = _h;
		
		if ( fullscreen )
		{
			var ds = display.getSize();
			ww = ds.x;
			hh = ds.y;
		}
		
		window_set_size(ww,hh);
		var cc = display.getCenter();
		var dc = display.getCenter();
		window_set_position(
			dc.x - cc.x,
			dc.y - cc.y
		);	
	}
	
}

function __WindowInstance()
{
	static instance = new __Window();
	return instance;
}
