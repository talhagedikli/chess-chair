//#macro TWEENS global.__tweens
//global.__tweens = [];

//function run_all_tweens()
//{
//	var _l = array_length(TWEENS);
//	for (var i = 0; i < _l; ++i) 
//	{
//		TWEENS[i].run();
//	}	
//}
/// @enum {number}
enum TweenType
{
	Linear,
	EaseIn,
	EaseOut,
	EaseInOut,
	CubicEaseIn,
	CubicEaseInOut,
	CubicEaseOut,
	QuartEaseIn,
	QuartEaseInOut,
	QuartEaseOut,
	ExpoEaseIn,
	ExpoEaseInOut,
	ExpoEaseOut,
	CircEaseIn,
	CircEaseInOut,
	CircEaseOut,
	BackEaseIn,
	BackEaseInOut,
	BackEaseOut,
	ElasticEaseIn,
	ElasticEaseInOut,
	ElasticEaseOut,
	BounceEaseIn,
	BounceEaseInOut,
	BounceEaseOut,
	FastToSlow,
	MidSlow
}
	
/// @param {*}		_type
/// @param {real}	[_dur]
/// @param {real}	[_start]
/// @param {real}	[_end]
/// @param {bool}	[_autostart]
/// @param {real}	[_ticksize]
/// @param {bool}	[_autorun]

function Tween(_type = TweenType.Linear, _dur=0, _start=0, _end=0, _autostart=false, _ticksize=1, _autorun=false) : Lwo() constructor
{
	channel		= animcurve_get_channel(acTweens, _type);
	duration	= _dur;
	time		= 0;
	timeLeft	= duration - time;
	done		= false;
	active		= _autostart;
	loop		= false;
	autorun		= _autorun;
	
	x1			= 0;
	x2			= 1;
	x			= 0;
	
	y1			= _start;
	y2			= _end;
	y			= y1;
	
	
	//if (autorun) array_push(TWEENS, self);
	
	__step_end__ = function()
	{
		if (autorun) run();
		return;
	}
	
	/// @param {real}	_start
	/// @param {real}	[_end]
	/// @param {real}	[_duration]
	/// @param {bool}	[_loop]
	static start = function(_start = y1, _end = y2, _duration = duration, _loop = false)
	{
		active		= true;
		y1			= _start;
		y2			= _end;
		duration	= _duration;
		loop		= _loop;
		timeLeft	= duration - time;
		// !!! Already exists in "run" method
		// var rate	= animcurve_channel_evaluate(channel, time / duration);
		// x			= rate;
	}
	static stop = function()
	{
		time	= 0;
		active	= false;
		done	= false;
		return self;
	}
	/// @param {real}	[_start]
	/// @param {real}	[_end]
	/// @param {real}	[_dur]
	static reset = function()
	{
		active		= true;
		//y1			= _start;
		//y2			= _end;
		//duration	= _duration;
		time		= 0;
		timeLeft	= duration - time;
		done		= false;
		return self;
	}
	static run = function()
	{
		if (active)
		{

			var rate	= animcurve_channel_evaluate(channel, time / duration);
			x			= rate;
			y			= lerp(y1, y2, rate);
			time		+= 1;
			timeLeft	= duration - time;
			// x = clamp(x, 0, 1);
			// y = clamp(y, y1, y2);
			// New
			if (done)
			{
				if (loop) reset();
				else stop();
			}			
			else if (time >= duration)
			{
				done = true;	
			}
			//if (time >= duration)
			//{
			//	done	= true;
			//	active	= false;
			//}
		}
		return self;
	}
	static getValue = function()
	{
		return self.y;
	}
	static getPossition = function()
	{
		return self.x;
	}
	static isActive = function()
	{
		return active;
	}
	/// @param {bool} _active
	static setActive = function(_active)
	{
		active = _active;
	}
	/// @param {real} _time
	static seekTime = function(_time)
	{
		return _time == floor(time) ? true : false;
	}
	/// @param {real} _rate
	static seekRate = function(_rate)
	{
		// Rate is a value between 0 and 1
		// 0 means just started 1 means ended
		return _rate >= x ? true : false;
	}
	/// @param {function} _func
	static onTimeout = function(_func)
	{
		if (done)
		{
			_func();
			//stop();
		}		
	}
}





