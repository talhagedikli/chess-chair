#macro PARTICLES global.__particles

global.__particles = [];

function Particle(_system) constructor
{
	system	= _system;
	type	= part_type_create();
	time	= 0;
	t		= new Timer(0);
	array_push(PARTICLES, self);
	
	/// @func Shape([shape])
	static Shape = function(_shape)
	{
		part_type_shape(type, _shape);
		return self;
	}
	
	/// @func Sprite(_spr, _anim, _stretch, _random)
	static Sprite = function(_spr, _anim, _stretch, _random)
	{
		part_type_sprite(type, _spr, _anim, _stretch, _random);
		return self;
	}
	
	/// @func Size(sz_min, sz_max = sz_min, sz_increase, sz_wiggle)
	static Size = function(sz_min, sz_max = sz_min, sz_increase, sz_wiggle)
	{
		part_type_size(type, sz_min, sz_max, sz_increase, sz_wiggle);
		return self;
	}
	
	/// @func Scale(_xscl, _yscl = _xscl)
	static Scale = function(_xscl, _yscl = _xscl)
	{
		part_type_scale(type, _xscl, _yscl);
		return self;
	}
	
	/// @func Speed(spd_min, spd_max, spd_inc, spd_wig)
	static Speed = function(spd_min, spd_max, spd_inc, spd_wig)
	{
		part_type_speed(type, spd_min, spd_max, spd_inc, spd_wig);
		return self;
	}
	
	/// @func Direction(dir_min, dir_max, dir_incr, dir_wig)
	static Direction = function(dir_min, dir_max, dir_incr, dir_wig)
	{
		part_type_direction(type, dir_min, dir_max, dir_incr, dir_wig);
		return self;
	}
	
	/// @func Gravity(grv_amount, grv_dir)
	static Gravity = function(grv_amount, grv_dir)
	{
		part_type_gravity(type, grv_amount, grv_dir);
		return self;
	}
	
	/// @func Orientation(ang_min, ang_max, ang_incr, ang_wig, ang_relative)
	static Orientation = function(ang_min, ang_max, ang_incr, ang_wig, ang_relative)
	{
		part_type_orientation(type, ang_min, ang_max, ang_incr, ang_wig, ang_relative);
		return self;
	}
	
	/// @func ColorMix(col1, col2)
	static ColorMix = function(col1, col2)
	{
		part_type_color_mix(type, col1, col2);
		return self;
	}
	
	/// @func ColorRGB(rmin, rmax, gmin, gmax, bmin, bmax)
	static ColorRGB = function(rmin, rmax, gmin, gmax, bmin, bmax)
	{
		part_type_color_rgb(type, rmin, rmax, gmin, gmax, bmin, bmax);
		return self;
	}
	
	/// @func ColorHSV(hmin, hmax, smin, smax, vmin, vmax)
	static ColorHSV = function(hmin, hmax, smin, smax, vmin, vmax)
	{
		part_type_color_hsv(type, hmin, hmax, smin, smax, vmin, vmax);
		return self;
	}
	
	/// @func Color1(col1)
	static Color1 = function(col1, col2 = col1, col3 = col1)
	{
		part_type_color1(type, col1);
		return self;
	}
	
	/// @func Color2(col1, col2 = col1)
	static Color2 = function(col1, col2 = col1)
	{
		part_type_color2(type, col1, col2);
		return self;
	}
	
	/// @func Color3(col1, col2 = col1, col3 = col1)
	static Color3 = function(col1, col2 = col1, col3 = col1)
	{
		part_type_color3(type, col1, col2, col3);
		return self;
	}
	
	/// @func Alpha1(a1)
	static Alpha1 = function(a1)
	{
		part_type_alpha1(type, a1);
		return self;
	}

	/// @func Alpha2(a1, a2 = a1)
	static Alpha2 = function(a1, a2 = a1)
	{
		part_type_alpha2(type, a1, a2);
		return self;
	}
	
	/// @func Alpha3(a1, a2 = a1, a3 = a1)
	static Alpha3 = function(a1, a2 = a1, a3 = a1)
	{
		part_type_alpha3(type, a1, a2, a3);
		return self;
	}	
	
	/// @func Blend(additive)
	static Blend = function(additive)
	{
		part_type_blend(type, additive);
		return self;
	}
	
	/// @func Life(l_min, l_max = l_min)
	static Life = function(l_min, l_max = l_min)
	{
		part_type_life(type, l_min, l_max);
		return self;
	}
	
	/// @func Step(stp_num, stp_type)
	static Step = function(stp_num, stp_type)
	{
		part_type_step(type, stp_num, stp_type);
		return self;
	}
	
	/// @func Death(death_num, death_type)
	static Death = function(death_num, death_type)
	{
		part_type_death(type, death_num, death_type);
		return self;
	}
	
	/// @func Emit(_x, _y, _num, _gap)
	static Emit = function(_x, _y, _num, _gap)
	{
		time++;
		if (time >= _gap)
		{
			with(other)
			{
				part_particles_create(other.system, _x, _y, other.type, _num);
			}
			time = 0;
		}
	}

	/// @func EmitColor(_x, _y, _col, _num, ticksize)
	static EmitColor = function(_x, _y, _col, _num, _gap)
	{
		time++;
		if (time >= _gap)
		{
			part_particles_create_color(system, _x, _y, type, _col, _num);
			time = 0;
		}
	}
	
	/// @func PTClear()
	static PTClear = function()
	{
		part_type_clear(type);
	}

	/// @func PSClear()
	static PSClear = function()
	{
		part_system_clear(system);
	}
	
	/// @func Destroy()
	static Destroy = function()
	{
		if (part_system_exists(system))
		{
			part_system_destroy(system);
		}
		if (part_type_exists(type))
		{
			part_type_destroy(type);
		}
	}
	
	static Type		= function()
	{
		return type;
	}
}