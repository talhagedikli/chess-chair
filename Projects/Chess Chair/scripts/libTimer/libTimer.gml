#macro TIMERS global.__timers
global.__timers = [];

function run_all_timers()
{
	var _l = array_length(TIMERS);
	for (var i = 0; i < _l; ++i) 
	{
		TIMERS[i].Run();
	}	
}
/// Feather disable GM1013 - from ERRORS to WARNINGS



/// @description Basic alarms with structs 
/// @param {real} _duration Duration
/// @param {bool} [_loop=false] description
/// @param {bool} [_autostart=false] description
function Timer(_duration, _loop=false, _autostart = false) constructor
{
	timeLeft	= 0.;
	duration	= _duration;
	time		= 0.;

	active		= _autostart;
	loop		= _loop;
	done		= false;
	array_push(TIMERS, self);
	
	static Start = function()
	{
		//duration	= _duration;
		//loop		= _loop;
		timeLeft	= duration - time;
		done		= false;
		active		= true;
		return self;
	}
	static Run = function()
	{
		if (active)
		{
			time		+= 1.;
			timeLeft	= duration - time;
			if (time >= duration)
			{
				done	= true;
				active	= false;
			}
		}
		return self;
	}
	///@param {real} _duration
	static SetDuration = function(_duration)
	{
		duration	= _duration;
		return self;
	}
	///@param {bool} _loop
	static SetLoop = function(_loop = bool(loop))
	{
		loop = _loop;
		return self;
	}
	///@param {function} _func 
	static OnTimeout = function(_func)
	{
		if (done)
		{
			_func();
			if (loop) Reset();
			else Stop();
		}
		return self;
	}
	static Reset = function()
	{
		time		= 0;
		//duration	= _duration;
		done		= false;
		active		= true;
		return self;

	}
	static Stop = function()
	{
		time	= 0;
		active	= false;
		done	= false;
		return self;
	}
	/// @param {bool} _active Set active
	static SetActive = function(_active)
	{
		active = _active;
		return self;
	}
	static IsActive = function()
	{
		return active;
	}
	static GetTime = function()
	{
		return time;
	}
	/// @param {real} _time Time to seek
	static SeekTime = function(_time)
	{
		return time == _time ? true : false;
	}
	static GetTimeLeft = function()
	{
		return timeLeft
	}
}
















