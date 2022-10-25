function draw_sprite_stacked(_sprite, _x, _y, _xscale, _yscale, _angle)
{
	var i = 0;
	repeat(image_number) 
	{ 
	   draw_sprite_ext(_sprite, i, _x, _y-i ,_xscale, _yscale, _angle, c_white, 1)
	   i ++
	}
}