part_system_destroy(global.PS);
part_system_destroy(global.PPS);

if (surface_exists(surPS)) 
{
	surface_free(surPS);
}

foreach(global.Particles, function(val)
{
	var t = val.Type();
	part_type_destroy(t);
	if (part_type_exists(t)) show("ERROR: part type not destroyed");
});
