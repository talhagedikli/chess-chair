#region Functions
// Set surface free safely
function surface_free_safe(sur)
{
	if (surface_exists(sur))
	{
		surface_free(sur);
	}
}

// Quick set halign and valign
function draw_set_aling(halign = fa_left, valign = fa_top)
{
	draw_set_halign(halign);
	draw_set_valign(valign);
}

// Quick set color and alpha
function draw_set_blend(color = c_white, alpha = 1)
{
	draw_set_color(color);
	draw_set_alpha(alpha);
}

// lengthdir_x and lengthdir_y together with vectors
function lengthdir(len = new Vector2(0), dir = new Vector2(0)) 
{
	return new Vector2(lengthdir_x(len.x, dir.x), lengthdir_y(len.y, dir.y));
}

//Concatenate a series of arguments into a string
function concat() 
{
    var _string = "";
    for(var i = 0; i < argument_count; i++) _string += string(argument[i]);
    return _string;
}
 
//Show debug message enhanced with string concatenation
function debug_message()
{
    var _string = "";
    for(var i = 0; i < argument_count; i++) _string += string(argument[i]);
    show_debug_message(_string);
}

//Show debug message enhanced with string concatenation
function screen_message()
{
    var _string = "";
    for(var i = 0; i < argument_count; i++) _string += string(argument[i]);
    show_message(_string);
}

//Move value towards another value by a given amount
function approach(_a, _b, _amount) 
{
    if (_a < _b)
    {
        _a += _amount;
        if (_a > _b)
            return _b;
    }
    else
    {
        _a -= _amount;
        if (_a < _b)
            return _b;
    }
    return _a;
}
 
// Sine waves a value between two values over a given time. 
function wave(_from, _to, _duration, _offset = 0) 
{
    var a4 = (_to - _from) * 0.5;
    return _from + a4 + sin((((current_time * 0.001) + _duration * _offset) / _duration) * (pi*2)) * a4; 
}
 
//Wraps a value between a minimum and a given wrap point
function wrap(_value, _minimum, _wrapAt) 
{
 
    var _mod = ( _value - _minimum ) mod ( _wrapAt - _minimum );
    if ( _mod < 0 ) return _mod + _wrapAt else return _mod + _minimum;
}

function normalize(value, min, max)
{
	var normalized = (value - min) / (max - min);
	normalized = clamp(normalized, 0, 1);
	return normalized;
}

///Map(val, min1, max1, min2, max2)   
function remap(value, min1, max1, min2, max2)
{
	/*      
	value = 110;      
	m = Map(value, 0, 100, -20, -10);      
	// m = -9      
	*/
	return min2 + (max2 - min2) * ((value - min1) / (max1 - min1));
}

/// @description
function chance(_percent)
{
	// Returns true or false depending on RNG
	// ex: 
	//		Chance(0.7);	-> Returns true 70% of the time
	return _percent > random(1);
}

// Finite lerp function
function flerp(val1, val2, amount, epsilon = EPSILON)
{
	return abs(val1 - val2) > epsilon ? lerp(val1, val2, amount) : val2;
}

// 2021-12-02 17:09:00
/// @return N/A (0)
/// 
/// Executes a method call for each element of the given struct/array/data structure.
/// This iterator is shallow and will not also iterate over nested structs/arrays (though
/// you can of course call foreach() inside the specified method)
/// 
/// This function can also iterate over all members of a ds_map, ds_list, or ds_grid.
/// You will need to specify a value for [dsType] to iterate over a data structure
///
/// The specified method is passed the following parameters:
/// 
/// arg0  -  Value found in the given struct/array
/// arg1  -  0-indexed index of the value e.g. =0 for the first element, =1 for the second element etc.
/// arg2  -  When iterating over structs, the name of the variable that contains the given value; otherwise <undefined>
/// 
/// The order that values are sent into <method> is guaranteed for arrays (starting at
/// index 0 and ascending), but is not guaranteed for structs due to the behaviour of
/// GameMaker's internal hashmap
/// 
/// @param struct/array/ds   Struct/array/data structure to be iterated over
/// @param method            Method to call for each element of this given struct/array/ds
/// @param [dsType]          Data structure type if iterating over a data structure
/// 
/// @jujuadams 2020-06-16

function foreach()
{
    var _ds       = argument[0];
    var _function = argument[1];
    var _ds_type  = (argument_count > 2)? argument[2] : undefined;
    
    if (is_struct(_ds))
    {
        var _names = variable_struct_get_names(_ds);
        var _i = 0;
        repeat(array_length(_names))
        {
            var _name = _names[_i];
            _function(variable_struct_get(_ds, _name), _i, _name);
            ++_i;
        }
    }
    else if (is_array(_ds))
    {
        var _i = 0;
        repeat(array_length(_ds))
        {
            _function(_ds[_i], _i, undefined);
            ++_i;
        }
    }
    else switch(_ds_type)
    {
        case ds_type_list:
            var _i = 0;
            repeat(ds_list_size(_ds))
            {
                _function(_ds[| _i], _i, undefined);
                ++_i;
            }
        break;
        
        case ds_type_map:
            var _i = 0;
            var _key = ds_map_find_first(_ds);
            repeat(ds_map_size(_ds))
            {
                _function(_ds[? _key], _i, _key);
                _key = ds_map_find_next(_ds, _key);
                ++_i;
            }
        break;
        
        case ds_type_grid:
            var _w = ds_grid_width( _ds);
            var _h = ds_grid_height(_ds);
            
            var _y = 0;
            repeat(_h)
            {
                var _x = 0;
                repeat(_w)
                {
                    _function(_ds[# _x, _y], _x, _y);
                    ++_x;
                }
                
                ++_y;
            }
        break;
        
        default:
            show_error("Cannot iterate over datatype \"" + string(typeof(_ds)) + "\"\n ", false);
        break;
    }
}

#endregion