	global.p_sys = part_system_create()
	part_system_depth(global.p_sys, -100)

	global.p_trail = part_type_create()
	part_type_sprite(global.p_trail, spr_chrono, false, false, false)
	part_type_life(global.p_trail, 12, 18)
	part_type_alpha3(global.p_trail, 0.6, 0.2, 0)
	part_type_size(global.p_trail, 1, 1, -0.02, 0)
	part_type_blend(global.p_trail, true)

	global.p_spark = part_type_create()
	part_type_shape(global.p_spark, pt_shape_spark)
	part_type_size(global.p_spark, 0.1, 0.3, -0.005, 0.1)
	part_type_color3(global.p_spark, c_lime, c_green, c_teal)
	part_type_alpha3(global.p_spark, 1, 0.8, 0)
	part_type_speed(global.p_spark, 1, 4, -0.05, 0)
	part_type_direction(global.p_spark, 0, 359, 2, 0)
	part_type_blend(global.p_spark, true)
	part_type_life(global.p_spark, 20, 35)

	global.p_vortex = part_type_create()
	part_type_shape(global.p_vortex, pt_shape_circle)
	part_type_size(global.p_vortex, 0.05, 0.15, 0, 0)
	part_type_color2(global.p_vortex, c_lime, c_white)
	part_type_alpha3(global.p_vortex, 0, 0.8, 0)
	part_type_speed(global.p_vortex, 2, 6, -0.15, 0)
	part_type_direction(global.p_vortex, 0, 359, 15, 0)
	part_type_blend(global.p_vortex, true)
	part_type_life(global.p_vortex, 30, 45)

	global.p_pulse = part_type_create();
	part_type_shape(global.p_pulse, pt_shape_ring);
	part_type_size(global.p_pulse, 0.1, 0.1, 0.1, 0); 
	part_type_color1(global.p_pulse, c_white);
	part_type_alpha2(global.p_pulse, 1, 0);
	part_type_life(global.p_pulse, 10, 15); 
	
	global.p_slime = part_type_create();
	part_type_shape(global.p_slime, pt_shape_disk);
	part_type_size(global.p_slime, 0.1, 0.2, -0.002, 0.02);
	part_type_color3(global.p_slime, c_lime, c_green, c_olive);
	part_type_alpha3(global.p_slime, 0.9, 0.7, 0);
	part_type_speed(global.p_slime, 1, 1.5, -0.02, 0);
	part_type_direction(global.p_slime, 0, 359, 0, 0);
	part_type_gravity(global.p_slime, 0.15, 270); 
	part_type_blend(global.p_slime, false); 
	part_type_life(global.p_slime, 30, 50);