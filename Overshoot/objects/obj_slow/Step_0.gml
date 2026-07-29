// Inherit the parent event
event_inherited();

if global.paused == false{
	
	t=delta_time / 1000000;
	cd+=t;

	if (cd>=cd_total)
	{
		cd=0;
		start_slow=true;
		player_x=obj_player.x;
		player_y=obj_player.y;
	
		part_particles_create(global.p_sys, player_x, player_y, global.p_pulse, 1)
	}

	if (start_slow==true)
	{
		slow+=t;
	
		if (random(1) > 0.6){
			part_particles_create(global.p_sys, player_x + random_range(-range, range), player_y + random_range(-range, range), global.p_vortex, 1)
			part_particles_create(global.p_sys, x, y, global.p_pulse, 1);
			
			
			x += random_range(-2, 2)
			y += random_range(-2, 2)
		}
	}

	if (slow>cd_slow)
	{
		slow=0;
		start_slow=false;
	
		part_particles_create(global.p_sys, player_x, player_y, global.p_pulse, 2)
	    part_particles_create(global.p_sys, player_x, player_y, global.p_spark, 15)
	
		if (point_distance(player_x,player_y,obj_player.x,obj_player.y)<=range)
		{
			slowing=true;
		}
	}
	if (slowing=true)
	{
		slowed+=t;
		obj_player.slow=0.3;
	}

	if (slowed>slow_time)
	{
		slowed=0;
		obj_player.slow=1;
		slowing=false;
	}
}