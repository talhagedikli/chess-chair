//#macro vec2 new Vector2
//#macro VECTOR2_ZERO		new Vector2(0)
//#macro VECTOR2_RANDOM	new Vector2(lengthdir_x(1, random(360), lengthdir_y(1, random(360))

/// @desc Vector2
/// @param {real} _x
/// @param {real} _y
/// @returns {struct.Vector2}
function Vector2(_x = 0, _y = _x) constructor
{
	self.x	= _x;
	self.y	= _y;
	///@param {real} _x
	///@param {real} _y
	static Set = function(_x, _y) 
	{
		x = _x;
		y = _y;
	}
	/// @param {Struct.Vector2} _vector
	static Add = function(_vector) 
	{
		x += _vector.x;
		y += _vector.y;
	}
	/// @param {Struct.Vector2} _vector
	static Subtract = function(_vector) 
	{
		x -= _vector.x;
		y -= _vector.y;
	}
	/// @param {real} _scalar
	static Multiply = function(_scalar) 
	{
		x *= _scalar;
		y *= _scalar;
	}
	/// @param {real} _scalar
	static Divide = function(_scalar) 
	{
		x /= _scalar;
		y /= _scalar;
	}
	static Negate = function()
	{
		x = -x;
		y = -y;
	}
	static Normalize = function() 
	{
		if ((x != 0) || (y != 0)) 
		{
			var _factor = 1/sqrt((x * x) + (y *y));
			x = _factor * x;
			y = _factor * y;	
		}
	}
	/// @param {real} _scalar
	static SetMagnitude = function(_scalar) 
	{
		Normalize();
		Multiply(_scalar);
	}
	/// @param {real} _limit
	static LimitMagnitude = function(_limit) {
		if (Length() > _limit) {
			SetMagnitude(_limit);
		}
	}
	/// @param {Struct.Vector2} _vector2
	static Copy = function(_vector2)
	{
		x = real(_vector2.x);
		y = real(_vector2.y);
	}
	
	static Absv = function()
	{
	    return (new Vector2(abs(x), abs(y)));
	}
	
	/// @param {real} radians
	static Angle = function(radians)
	{
	    return (radians) ? arctan2(y, x) : darctan2(y, x);
	}

	static Length = function()
	{
	    return point_distance(0, 0, x, y);
	}

	static LengthSquared = function()
	{
	    return (x * x + y * y);
	}

	static Normalized = function()
	{
	    var _vector = self;
	    _vector.Normalize();
	    return _vector;
	}

	static IsNormalized = function()
	{
	    var _epsilon = 0.0001;
	    var _difference = abs(LengthSquared() - 1.0);
	    return (_difference < _epsilon);
	}
	
	/// @param {Struct.Vector2} vector2
	static DistanceTo = function(vector2)
	{
	    var _check = instanceof(vector2);
	    if (is_string(_check))
	    {
	        return sqrt((x - vector2.x) * (x - vector2.x) + (y - vector2.y) * (y - vector2.y));
	    }
	    else
	    {
	        return undefined;
	    }
	}
	/// @param {Struct.Vector2} vector2
	static DistanceToSquared = function(vector2)
	{
	    var _check = instanceof(vector2);
	    if (is_string(_check))
	    {
	        return ((x - vector2.x) * (x - vector2.x) + (y - vector2.y) * (y - vector2.y));
	    }
	    else
	    {
	        return undefined;
	    }
	}
	/// @param {Struct.Vector2} vector2
	/// @param {real} radians
	static AngleTo = function(vector2, radians)
	{
	    var _check = instanceof(vector2);
	    if (is_string(_check))
	    {
	        return (radians) ? arctan2(Cross(vector2), Dot(vector2)) : darctan2(Cross(vector2), Dot(vector2));
	    }
	    else
	    {
	        return undefined;
	    }
	}
	
	/// @param {Struct.Vector2} vector2
	/// @param {bool}			radians
	static AngleToPoint = function(vector2, radians)
	{
	    var _check = instanceof(vector2);
	    if (is_string(_check))
	    {
	        return (radians) ? arctan2(y - vector2.y, x - vector2.x) : darctan2(y - vector2.y, x - vector2.x);
	    }
	    else
	    {
	        return undefined;
	    }
	}
	/// @param {Struct.Vector2} vector2
	static Dot = function(vector2)
	{
	    return (x * vector2.x + y * vector2.y);
	}
	/// @param {Struct.Vector2} vector2
	static Cross = function(vector2)
	{
	    return (x * vector2.x - y * vector2.y);
	}

	static Signv = function()
	{
	    return (new Vector2(sign(x), sign(y)));
	}

	static Floorv = function()
	{
	    return (new Vector2(floor(x), floor(y)));
	}

	static Ceilv = function()
	{
	    return (new Vector2(ceil(x), ceil(x)));
	}

	static Roundv = function()
	{
	    return (new Vector2(round(x), round(y)));
	}
	/// @param {real} by_amount
	/// @param {bool} radians?
	/// @desc Returns the vector rotated by the amount supplied in degrees or radians.
	static Rotated = function(by_amount, radians)
	{
	    var _sine = (radians) ? sin(by_amount) : dsin(by_amount);
	    var _cosi = (radians) ? cos(by_amount) : dcos(by_amount);
	    return (new Vector2(x * _cosi - y * _sine, x * _sine + y * _cosi));
	}

	/// @param vector2
	/// @desc Returns the vector projected onto the given vector.
	static Project = function(vector2)
	{
	    return (vector2 * (Dot(vector2) / vector2.length_squared()));
	}

	/// @func snapped()
	/// @param vector2
	/// @desc Returns this vector with each component snapped to the nearest multiple of step.
	static Snapped = function(vector2)
	{
	    return new Vector2(floor(x / vector2.x + 0.5) * vector2.x, floor(y / vector2.y + 0.5) * vector2.y);
	}

	/// @func clamped()
	/// @param max_length
	/// @desc Returns the vector with a maximum length by limiting its length to length.
	static Clamped = function(max_length)
	{
	    var _length = Length();
	    var _vector = self;
	    if (_length > 0 and max_length < _length)
	    {
	        _vector.x /= _length;
	        _vector.y /= _length;
	        _vector.x *= max_length;
	        _vector.y *= max_length;
	    }

	    return _vector;
	}

	/// @func move_toward()
	/// @param vector2
	/// @param delta
	/// @desc Moves the vector toward vector2 by the fixed delta amount.
	static MoveToward = function(vector2, delta)
	{
	    var _vector = self;
	    var _epsilon = 0.0001;
	    var _vector_delta = new Vector2(vector2.x - _vector.x, vector2.y - _vector.y);
	    var _length = _vector_delta.Length();

	    if (_length <= delta or _length < _epsilon)
	    {
	        return vector2;
	    }
	    else
	    {
	        return new Vector2(_vector.x + _vector_delta.x / _length * delta, _vector.y + _vector_delta.y / _length * delta);
	    }
	}

	/// @func is_approx_equal()
	/// @param vector2
	/// @desc Returns true if this vector and v are approximately equal.
	static IsApproxEqual = function(vector2)
	{
	    var _epsilon = 0.0001;
	    var _x_difference = abs(x - vector2.x);
	    var _y_difference = abs(y - vector2.y);
	    return (_x_difference < _epsilon and _y_difference < _epsilon);
	}
	
	/// @func is_equal()
	/// @param vector2
	static IsEqual = function(vector2)
	{
		return vector2.x == x && vector2.y == y;
	}

	static toString = function()
	{
	    return ("{ " + string(x) + ", " + string(y) + " }");
	}
}

/// @param {real} _x
/// @param {real} _y
/// @param {real} _z
function Vector3(_x, _y, _z) constructor {
	x = _x;
	y = _y;
	z = _z;
	
	static to_string = function() {
		return "[ " + string(x) + ", " + string(y) + ", " + string(z) + " ]";
	}
	
	static add = function(_vec3) {
		return new Vector3(x + _vec3.x, y + _vec3.y, z + _vec3.z);
	}
	
	static subtract = function(_vec3) {
		return new Vector3(x - _vec3.x, y - _vec3.y, z - _vec3.z);
	}
}











