/// @script Hyena
#macro na __naInstance()
#macro ns __nsInstance()
#region ARRAY DATA
enum ArrayOperation 
{
	Add,
	Substact,
	Multiply,
	Divide,
	Div,
	Mod,
	Equality
}
function hyena() constructor
{
	/// @param {var} ...
	static array = function()
	{
		var a = [];
		var i = 0; repeat(argument_count)
		{
			array_push(a, argument[i]);
			i++;
		}
		return a;
	}
	static join = function(_array)
	{
		var a = [];
		for (var i = 0; i < size(_array); ++i) {
		    // code here
		}
	}
	static range = function(_range)
	{
		var a = [];
		var i = 0; repeat(_range)
		{
			array_push(a, i);
			i++;
		}
		return a;
	}
	static arange = function(_start, _end, _increase)
	{
		var a = [];
		if (_increase >= 0)
		{
			for (var i = _start; i < _end; i++) 
			{
				array_push(a, i);
			}
			// TO-DO: Switch to repeat
			// TO-DO: Random integer range
			//var i = _start; repeat(abs(_end - _start))
			//{
				
			//}
		}
		else
		{
			for (var i = _end - 1; i >= _start; i--) 
			{
				array_push(a, i);
			}
		}
		return a;
	}
	/// @param {array} _array
	static resize = function(_array, _size)
	{
		array_resize(_array, _size);
	}
	/// @param {array} _array
	static size = function(_array)
	{
		return array_length(_array);	
	}
	/// @param {array} _array
	static push = function(_array, _data)
	{
		for(var i = 0; i < array_length(_data); i++) 
		{
			array_push(_array, _data[i])
		}
	}
	/// @desc Loop
	/// @param {array}		_array
	/// @param {function}	_func
	/// @param {bool}		_backwards
	static loop = function(_array, _func, _backwards=false)
	{
		if (!_backwards)
		{
	        var i = 0;
	        repeat(array_length(_array))
	        {
	            _func(_array[i], i, _array, undefined);
	            ++i;
	        }
		}
		else
		{
			var i = size(_array) - 1;
			repeat(size(_array))
			{
				_func(_array[i], i, _array, undefined);
				--i;
			}
		}
	}	
	/// @desc Indexing and slicing
	/// @param {array} _array
	static slice = function(_array, _start=0, _end=array_length(_array), _increase=1)
	{
		var a = [];
		if (_increase >= 0)
		{
	        var i = _start;
	        repeat(abs(_end - _start))
	        {
	            array_push(a, _array[i]);
	            i += _increase;
	        }
		}
		else
		{
			var i = _end - 1;
			repeat(abs(_end - _start))
			{
				array_push(a, _array[i]);
				i+= _increase;
			}
		}
		return a;
	}
	/// @param {array} _array
	static pop = function(_array)
	{
		array_pop(_array);
	}
	/// @param {array} _array
	static copy = function(_array, _start=0, _len=size(_array))
	{
		var a = [];
		array_copy(a, 0, _array, _start, _len);
		return a;
		
	}
	/// @param {array}		_array
	/// @param {real}		_index
	/// @param {mixed}		_data
	static insert = function(_array, _index, _data)
	{
		array_insert(_array, _index, _data);	
	}
	/// @param {array}		_array
	/// @param {real}		_index
	static get = function(_array, _index)
	{
		return _array[_index];	
	}
	/// @param {array}		_array
	/// @param {mixed}		_value
	static find = function(_array, _value)
	{
		loop(_array, function(value, key, arr, _value)
		{
			if (value == _value)
			{
				return key;
			}
		});
		return undefined;
	}
	/// @param {array}		_array
	/// @param {real}		_index
	static set = function(_array, _index, _data)
	{
		_array[@ _index] = _data;	
	}
	/// @param {array}		_array
	/// @param {function}	_func
	static sort = function(_array, _func)
	{
		array_sort(_array, _func);
	}
	/// @param {array}		_array1
	/// @param {array}		_array2
	static equals = function(_array1, _array2)
	{
		return array_equals(_array1, _array2);	
	}
	/// @param {array} _array
	static shuffle = function(_array)
	{
		array_sort(_array, function() 
		{
			return irandom_range(-1, 1);
		});
	}

}
function __naInstance() 
{
	static instance = new hyena();
	return instance;
}
#endregion
#region STRUCT DATA
function hyesa() constructor
{
	/// @param {var} ...
	static struct = function()
	{
		var a = [];
		var i = 0; repeat(argument_count)
		{
			array_push(a, argument[i]);
			i++;
		}
		return a;
	}
	/// @param {array} _array
	static size = function(_struct)
	{	
        var _names = variable_struct_get_names(_struct);
		return array_length(_names);	
	}

	/// @desc Process
	/// @param {struct}		_struct
	/// @param {function}	_func
	/// @param {bool}		_backwards
	static loop = function(_struct, _func, _backwards=false)
	{
		if (!_backwards)
		{
		    if (is_struct(_struct))
		    {
		        var _names = variable_struct_get_names(_struct);
		        var _i = 0;
		        repeat(array_length(_names))
		        {
		            var _name = _names[_i];
		            _func(variable_struct_get(_struct, _name), _name, _i, _struct);
		            ++_i;
		        }
		    }
		}
		else
		{
		    if (is_struct(_struct))
		    {
		        var _names = variable_struct_get_names(_struct);
				var _l = size(_struct);
		        var i = _l - 1;
		        repeat(_l)
		        {
		            var _name = _names[_i];
		            _func(variable_struct_get(_struct, _name), _name, _i, _struct);
		            --i;
		        }
		    }
		}
	}	

	static copy = function(_array, _start=0, _len=size(_array))
	{
		var a = [];
		array_copy(a, 0, _array, _start, _len);
		return a;
		
	}
	static get = function(_struct, _name)
	{
		return _struct[$ _name];	
	}
	static find = function(_struct, _value)
	{
		    if (is_struct(_struct))
		    {
		        //var _names = variable_struct_get_names(_struct);
		    }
	}
	static set = function(_struct, _name, _data)
	{
		_struct[$ _name] = _data;	
	}
}
function __nsInstance() 
{
	static instance = new hyesa();
	return instance;
}
#endregion
//var a = na.array(0, 1, 2, 3, 4, 5);
//na.loop(a, function(val, key, arr)
//{
//	arr[@ key] *= val;
//});
//show(a);

var array = na.arange(0, 5, 2);