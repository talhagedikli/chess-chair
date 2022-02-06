#macro TWEENS global.__tweens
global.__tweens = [];

function run_all_tweens()
{
	var _l = array_length(TWEENS);
	for (var i = 0; i < _l; ++i) 
	{
		TWEENS[i].Run();
	}	
}
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

function Tween(_type = TweenType.Linear, _dur = 0, _start = 0, _end = 0, _autostart = false, _ticksize = 1) constructor
{
	channel		= animcurve_get_channel(acTweens, _type);
	duration	= _dur;
	time		= 0;
	timeLeft	= duration - time;
	done		= false;
	active		= _autostart;
	loop		= false;
	
	x1			= 0;
	x2			= 1;
	x			= 0;
	
	y1			= _start;
	y2			= _end;
	y			= y1;
	
	// Not used yet
	reverse 	= false;
	
	array_push(TWEENS, self);

	/// @param {real}	_start
	/// @param {real}	[_end]
	/// @param {real}	[_duration]
	/// @param {bool}	[_loop]
	static Start = function(_start = y1, _end = y2, _duration = duration, _loop = false)
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
	static Stop = function()
	{
		time	= 0;
		active	= false;
		done	= false;
		return self;
	}
	/// @param {real}	[_start]
	/// @param {real}	[_end]
	/// @param {real}	[_dur]
	static Reset = function(_start = y1, _end = y2, _duration = duration)
	{
		active		= true;
		y1			= _start;
		y2			= _end;
		duration	= _duration;
		time		= 0;
		timeLeft	= duration - time;
		done		= false;
		return self;
	}
	static Run = function()
	{
		if (active)
		{
			time		+= 1;
			timeLeft	= duration - time;
			var rate	= animcurve_channel_evaluate(channel, time / duration);
			x			= rate;
			y			= lerp(y1, y2, rate);
			// x = clamp(x, 0, 1);
			// y = clamp(y, y1, y2);
			if (time >= duration)
			{
				done	= true;
				active	= false;
			}
		}
		return self;
	}
	static GetValue = function()
	{
		return self.y;
	}
	static GetRate = function()
	{
		return self.x;
	}
	static IsActive = function()
	{
		return active;
	}
	/// @param {bool} _active
	static SetActive = function(_active)
	{
		active = _active;
	}
	/// @param {real} _time
	static SeekTime = function(_time)
	{
		return _time == floor(time) ? true : false;
	}
	/// @param {real} _rate
	static SeekRate = function(_rate)
	{
		// Rate is a value between 0 and 1
		// 0 means just started 1 means ended
		return _rate >= x ? true : false;
	}
	/// @param {function} _func
	static OnTimeout = function(_func)
	{
		if (done)
		{
			_func();
			Stop();
		}		
	}
}




