#macro TIMERS	global.__timers
#macro timer	new Timer
global.__timers = [];

function run_all_timers()
{
	var _timers_len = array_length(TIMERS);
	
	for (var i = 0; i < _timers_len; ++i) 
	{
	    TIMERS[i].Run();
	}	
}

function Timer(_duration, _loop = false, _autostart = false) constructor
{ // For basic timer
	time		= 0;
	timeLeft	= 0;
	duration	= _duration;

	active		= _autostart;
	loop		= _loop;
	done		= false;
	array_push(TIMERS, self);

	static Start = function(_duration = duration, _loop = loop)
	{
		duration	= _duration;
		loop		= _loop;
		timeLeft	= duration - time;
		done	= false;
		active	= true;
		return self;
	}
	static Run = function()
	{
		if (active)
		{
			time		+= 1;
			timeLeft	= duration - time;
			if (time >= duration)
			{
				done	= true;
				active	= false;
			}
		}
		return self;
	}
	static SetDuration = function(_duration)
	{
		duration	= _duration;
		return self;
	}
	static SetLoop = function(_loop)
	{
		loop = _loop;
	}
	static OnTimeout = function(_func)
	{
		if (done)
		{
			_func();
			Stop();
			if (loop) self.Reset();
		}
		return self;
	}
	static Reset = function(_duration = duration)
	{
		time		= 0;
		duration	= _duration;
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
		return self.time;
	}
	static SeekTime = function(_time)
	{
		return time == _time ? true : false;
	}
	static GetTimeLeft = function()
	{
		return self.timeLeft
	}
}