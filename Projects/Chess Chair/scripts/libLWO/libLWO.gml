#macro LWO global.__lwo
global.__lwo = [];
function lwo_init()
{
	var _l = array_length(LWO);
	for (var i = 0; i < _l; ++i) 
	{
		with (LWO[i])
		{
			if (self.__init__ == undefined) break;
			self.__init__();
		}
	}	
}
function lwo_step()
{
	var _l = array_length(LWO);
	for (var i = 0; i < _l; ++i) 
	{
		with (LWO[i])
		{
			if (self.__step__ == undefined) break;
			self.__step__();
		}
	}
}

function lwo_step_end()
{
	var _l = array_length(LWO);
	for (var i = 0; i < _l; ++i) 
	{
		with (LWO[i])
		{
			if (self.__step_end__ == undefined) break;
			self.__step_end__();
		}
	}
}
function lwo_step_begin()
{
	var _l = array_length(LWO);
	for (var i = 0; i < _l; ++i) 
	{
		with (LWO[i])
		{
			if (self.__step_begin__ == undefined) break;
			self.__step_begin__();
		}
	}
}
function lwo_draw()
{
	var _l = array_length(LWO);
	for (var i = 0; i < _l; ++i) 
	{
		with (LWO[i])
		{
			if (self.__draw__ == undefined) break;
			self.__draw__();
		}
	}	
}


function Lwo() constructor
{
	static _id = noone;
	_id++;
	array_push(LWO, self);
	static __init__			= undefined;
	static __step__			= undefined;
	static __step_begin__	= undefined;
	static __step_end__		= undefined;
	static __draw__			= undefined;
	return self;
}

