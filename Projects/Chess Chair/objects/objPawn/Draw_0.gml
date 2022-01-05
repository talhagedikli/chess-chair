draw_self();
var pp = objTestTable.getRealPosition(vec2(0, 0));
draw_rectangle_color(pp.x, pp.y, pp.x + GRID_WIDTH, pp.y + GRID_HEIGHT, c_blue, c_green, c_blue, c_green, false);