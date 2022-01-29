function timers()
{
	static data = [];
	return data;
}

function run_all_timers()
{
	var _l = array_length(timers());
	for (var i = 0; i < _l; ++i) 
	{
		var a = timers()[i];
		a.Run();
	}	
}

/// @param {real} _duration		Duration
/// @param {bool} _loop			Loop
/// @param {bool} _autostart	Auto Start
function Timer(_duration, _loop = false, _autostart = false) constructor
{ // For basic timer
	time		= 0;
	timeLeft	= 0;
	duration	= _duration;

	active		= _autostart;
	loop		= _loop;
	done		= false;
	array_push(timers(), self);
	
	static Start = function()
	{
		//duration	= _duration;
		//loop		= _loop;
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
	static SetDuration = function(_duration = duration)
	{
		duration	= _duration;
		return self;
	}
	static SetLoop = function(_loop = loop)
	{
		loop = _loop;
	}
	/// @param {function} _func Function to run on timeout
	static OnTimeout = function(_func)
	{
		if (done)
		{
			_func();
			Stop();
			if (loop) Reset();
		}
		return self;
	}
	/// @param {real} _duration
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
		return self.time;
	}
	/// @param {real} _time Time to seek
	static SeekTime = function(_time)
	{
		return self.time == _time ? true : false;
	}
	static GetTimeLeft = function()
	{
		return self.timeLeft
	}
}