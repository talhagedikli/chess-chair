line		= [1, 2, 3, 4, 5, 6, 7, 8];
row			= [rows.a, rows.b, rows.c, rows.d, rows.e, rows.f, rows.g, rows.h]
enum rows {
	a,
	b,
	c,
	d,
	e,
	f,
	g,
	h
}
tablePos = {};
var p = 0;
var i = 0; repeat(8)
{
	var j = 0; repeat(8)
	{
		tablePos[$ string(p)] = new Vector2(row[i], line[j]);
		p++;
		j++;
	}
	i++;
}
getRealPosition = function(_vec)
{
	return new Vector2(bbox_left + _vec.x * DATA_VIEW.gridSize.x, bbox_top + _vec.y * DATA_VIEW.gridSize.y);
}