if (hit_cooldown <= 0) {

    obj_player.hp -= spike_damage
    
    var _knockback_dir = point_direction(x, y, obj_player.x, obj_player.y)
    
    obj_player.xspeed = (obj_player.xspeed * spike_slow) + lengthdir_x(spike_knockback, _knockback_dir)
    obj_player.yspeed = (obj_player.yspeed * spike_slow) + lengthdir_y(spike_knockback, _knockback_dir)
    
    hit_cooldown = hit_cooldown_duration
}