var game_speed = obj_game_manager.game_speed

//damage from player collision
if (hit_cooldown <= 0) {
    var _hit = false
    var _enemy_id = id
    with (obj_player) {
        if (place_meeting(x + xspeed, y, _enemy_id) || place_meeting(x, y + yspeed, _enemy_id)) {
            _hit = true
        }
    }
    if (_hit) {
        var _player_speed = point_distance(0, 0, obj_player.xspeed, obj_player.yspeed)
        var _damage = _player_speed * damage_scale
        if (_damage > 0) {
			
            enemy_hp -= _damage
            hit_cooldown = hit_cooldown_duration
            var _knock_dir = point_direction(obj_player.x, obj_player.y, x, y)
            knockback_x = lengthdir_x(_player_speed * knockback_force, _knock_dir)
            knockback_y = lengthdir_y(_player_speed * knockback_force, _knock_dir)
            hit_squash_timer = hit_squash_duration
            flash_timer = flash_duration
			
            if (enemy_hp <= 0) {
				
				obj_rating.popup_value += obj_rating.time_gain_kill
				obj_rating.popup_timer = obj_rating.popup_duration
				obj_rating.room_time += obj_rating.time_gain_kill
				
                instance_destroy()
				
				
            }
        }
    }
}

//knockback cooldown tick
if (hit_cooldown > 0) {
    hit_cooldown -= 1 * game_speed
}

//prevent enemy from going into the wall
if (!place_meeting(x + knockback_x, y, obj_wall)) {
    x += knockback_x * game_speed
} else {
    knockback_x = 0
}
if (!place_meeting(x, y + knockback_y, obj_wall)) {
    y += knockback_y * game_speed
} else {
    knockback_y = 0
}
x = clamp(x, 0, room_width)
y = clamp(y, 0, room_height)
knockback_x *= knockback_friction
knockback_y *= knockback_friction

//squash and stretch
if (hit_squash_timer > 0) {
    hit_squash_timer -= 1 * game_speed
    var _hit_ratio = hit_squash_timer / hit_squash_duration
    image_xscale = 1 - hit_squash_amount * _hit_ratio
    image_yscale = 1 + hit_squash_amount * _hit_ratio
} else {
    image_xscale = lerp(image_xscale, 1, 0.2 * game_speed)
    image_yscale = lerp(image_yscale, 1, 0.2 * game_speed)
}

//visual damage flash (white flash when hit)
if (flash_timer > 0) {
    flash_timer -= 1 * game_speed
}