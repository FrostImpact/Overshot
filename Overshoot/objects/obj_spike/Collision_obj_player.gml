if (hit_cooldown <= 0) {
    obj_player.hp -= spike_damage
    obj_player.xspeed *= spike_slow
    obj_player.yspeed *= spike_slow
    obj_spike.hit_cooldown = hit_cooldown_duration
	
}