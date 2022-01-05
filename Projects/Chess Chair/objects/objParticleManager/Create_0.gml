surPS = -1;

#region Systems
#macro PARTICLE_SYSTEM global.__part_systems

global.__part_systems = 
{
	main : part_system_create(),
};
part_system_depth(PARTICLE_SYSTEM.main, -100002);
part_system_automatic_update(PARTICLE_SYSTEM.main, true);
part_system_automatic_draw(PARTICLE_SYSTEM.main, true);

global.PS = part_system_create();
part_system_depth(global.PS, -100002);
part_system_automatic_update(global.PS, true);
part_system_automatic_draw(global.PS, true);

global.PPS = part_system_create();
part_system_depth(global.PPS, -1);
part_system_automatic_update(global.PPS, true);
part_system_automatic_draw(global.PPS, true);
#endregion


global.Particles = {};

with (global.Particles)
{
	// upper		= new Particle(global.PS).Shape(pt_shape_flare).Alpha3(0.3, 1, 0.2).Life(30, 50).Gravity(0.03, 90).Scale(0.05).Blend(true).Direction(80, 110, 0, false);
	// ghostDash	= new Particle(global.PS).Alpha3(0.3, 1, 0.2).Life(20, 50).Death(1, upper.Type());
}