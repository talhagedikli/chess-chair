if (surface_exists(surView)) {
    //draw_surface_part(view_surf, frac(x), frac(y), viewWidth, viewHeight, 0, 0);
	//draw_surface_part(view_surf, frac(x), frac(y), viewWidth, viewHeight, 0, 0);
	//var ax = camera_get_view_x(view) - x;
	//var ay = camera_get_view_y(view) - y;
	//draw_surface(view_surf, ax, ay);
	// draw_surface(view_surf, 0, 0);
	draw_surface(surView, -frac(x), -frac(y));
	 //draw_surface_part(surView, frac(x), frac(y), width, height, 0, 0);
}