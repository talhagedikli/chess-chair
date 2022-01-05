/// @description check 1 pixel collisions
//
function check_collisions_classic(_motion) {
	//horizontal collision
	if (tile_meeting(x+_motion.x, y, "Matrix"))
	{
		while (!tile_meeting(x+sign(_motion.x), y, "Matrix"))
		{
			x = x + sign(_motion.x);
		}
		_motion.x = 0;
	}
	// applying _motion.x
	x = x + _motion.x;

	//vertical collision
	if (tile_meeting(x, y+_motion.y, "Matrix"))
	{
		while (!tile_meeting(x, y+sign(_motion.y), "Matrix"))
		{
			y = y + sign(_motion.y);
		}
		_motion.y = 0;
	}
	//applying _motion.y
	y = y + _motion.y;

}


function check_collisions_pixel_perfect(_object = objBlock, _motion, _applyspd = true) { /// @description the pixel perfect collisions

	//I think this is better calculation for single mask
	var sprite_bbox_top		= sprite_get_bbox_top(sprite_index)		- sprite_get_yoffset(sprite_index);
	var sprite_bbox_bottom	= sprite_get_bbox_bottom(sprite_index)	- sprite_get_yoffset(sprite_index);
	var sprite_bbox_right	= sprite_get_bbox_right(sprite_index)	- sprite_get_xoffset(sprite_index);
	var sprite_bbox_left	= sprite_get_bbox_left(sprite_index)	- sprite_get_xoffset(sprite_index);

	//Applying horizontal speed if there is no collision with block
	if (_applyspd) x += _motion.x;
	//Horizontal collisions
	if place_meeting(x + sign(_motion.x), y, _object) {
		var wall = instance_place(x + sign(_motion.x), y, _object);
		if (_motion.x > 0)
		{ //right
			x = (wall.bbox_left - 1) - sprite_bbox_right;
		} 
		else if (_motion.x < 0)
		{ //left
			x = (wall.bbox_right + 1) - sprite_bbox_left;
		}
		_motion.x = 0;
	}

	//Applying vertical speed if there is no collision with block
	if (_applyspd) y += _motion.y;
	//Vertical collisions
	if place_meeting(x, y + sign(_motion.y), _object) {
		var wall = instance_place(x, y + sign(_motion.y), _object);
		if (_motion.y > 0)
		{ //down
			y = (wall.bbox_top - 1) - sprite_bbox_bottom;
		}
		else if (_motion.y < 0)
		{ //up
			y = (wall.bbox_bottom + 1) - sprite_bbox_top;
		}
		_motion.y = 0;
	}
}

function check_collisions_pixel_perfect_topdown(_object = objBlock, _motion, _dir) { /// @description the pixel perfect collisions

	//I think this is better calculation for single mask
	var sprite_bbox_top		= sprite_get_bbox_top(sprite_index)		- sprite_get_yoffset(sprite_index);
	var sprite_bbox_bottom	= sprite_get_bbox_bottom(sprite_index)	- sprite_get_yoffset(sprite_index);
	var sprite_bbox_right	= sprite_get_bbox_right(sprite_index)	- sprite_get_xoffset(sprite_index);
	var sprite_bbox_left	= sprite_get_bbox_left(sprite_index)	- sprite_get_xoffset(sprite_index);

	// Applying horizontal speed if there is no collision with block
	// x += lengthdir_x(_motion.x, _dir);
	//Horizontal collisions
	if place_meeting(x + sign(_motion.x), y, _object) {
		var wall = instance_place(x + sign(_motion.x), y, _object);
		if (_motion.x > 0)
		{ //right
			x = (wall.bbox_left - 1) - sprite_bbox_right;
		} 
		else if (_motion.x < 0)
		{ //left
			x = (wall.bbox_right + 1) - sprite_bbox_left;
		}
		_motion.x = 0;
	}

	//Applying vertical speed if there is no collision with block
	// y += lengthdir_y(_motion.y, _dir);
	//Vertical collisions
	if place_meeting(x, y + sign(_motion.y), _object) {
		var wall = instance_place(x, y + sign(_motion.y), _object);
		if (_motion.y > 0)
		{ //down
			y = (wall.bbox_top - 1) - sprite_bbox_bottom;
		}
		else if (_motion.y < 0)
		{ //up
			y = (wall.bbox_bottom + 1) - sprite_bbox_top;
		}
		_motion.y = 0;
	}
}

function check_collisions_tile_perfect(_motion) { /// @description the pixel perfect collisions

	//I think this is better calculation for single mask
	var sprite_bbox_top		= sprite_get_bbox_top(sprite_index)		- sprite_get_yoffset(sprite_index);
	var sprite_bbox_bottom	= sprite_get_bbox_bottom(sprite_index)	- sprite_get_yoffset(sprite_index);
	var sprite_bbox_right	= sprite_get_bbox_right(sprite_index)	- sprite_get_xoffset(sprite_index);
	var sprite_bbox_left	= sprite_get_bbox_left(sprite_index)	- sprite_get_xoffset(sprite_index);
	
	//Applying horizontal speed if there is no collision with block
	x += _motion.x;
	//Horizontal collisions
	if tile_meeting(x + sign(_motion.x), y, "CollidibleTile") {
		var wall = tilemap_get_at_pixel(tile, x + sign(_motion.x), y);
		if (_motion.x > 0)
		{ //right
			x = (wall.bbox_left - 1) - sprite_bbox_right;
		} 
		else if (_motion.x < 0)
		{ //left
			x = (wall.bbox_right + 1) - sprite_bbox_left;
		}
		_motion.x = 0;
	}

	//Applying vertical speed if there is no collision with block
	y += _motion.y;
	//Vertical collisions
	if tile_meeting(x, y + sign(_motion.y), "CollidibleTile") {
		var wall = tilemap_get_at_pixel(tile, x, y + sign(_motion.y));
		if (_motion.y > 0)
		{ //down
			y = (wall.bbox_top - 1) - sprite_bbox_bottom;
		}
		else if (_motion.y < 0)
		{ //up
			y = (wall.bbox_bottom + 1) - sprite_bbox_top;
		}
		_motion.y = 0;
	}


}



///@description tile_meeting(x,y,layer)
///@param x
///@param y
///@param layer
function tile_meeting(_x, _y, _layer) 
{
var _tm	= layer_tilemap_get_id(_layer);
 
var _x1 = tilemap_get_cell_x_at_pixel(_tm, bbox_left + (_x - x), y),
	_y1 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_top + (_y - y)),
	_x2 = tilemap_get_cell_x_at_pixel(_tm, bbox_right + (_x - x), y),
	_y2 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_bottom + (_y - y));
 
	for(var _xx = _x1; _xx <= _x2; _xx++)
	{
		for(var _yy = _y1; _yy <= _y2; _yy++)
		{
			if(tile_get_index(tilemap_get(_tm, _xx, _yy)))
			{
				return true;
			}
		}
	}
	return false;
}

///@description tile_meeting_precise(x,y,layer)
///@param x
///@param y
///@param layer
function tile_meeting_precise(argument0, argument1, argument2) {
	var _layer = argument2,
	    _tm = layer_tilemap_get_id(_layer),
	    _checker = obj_precise_tile_checker;
	if(!instance_exists(_checker)) instance_create_depth(0,0,0,_checker);  

 
	var _x1 = tilemap_get_cell_x_at_pixel(_tm, bbox_left + (argument0 - x), y),
	    _y1 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_top + (argument1 - y)),
	    _x2 = tilemap_get_cell_x_at_pixel(_tm, bbox_right + (argument0 - x), y),
	    _y2 = tilemap_get_cell_y_at_pixel(_tm, x, bbox_bottom + (argument1 - y));
 
	for(var _x = _x1; _x <= _x2; _x++){
	  for(var _y = _y1; _y <= _y2; _y++){
	var _tile = tile_get_index(tilemap_get(_tm, _x, _y));
	if(_tile){
	  if(_tile == 1) return true;
     
	  _checker.x = _x * tilemap_get_tile_width(_tm);
	  _checker.y = _y * tilemap_get_tile_height(_tm);
	  _checker.image_index = _tile;
     
	  if(place_meeting(argument0,argument1,_checker))
	    return true;
	}
	}
	}
 
	return false;


}
