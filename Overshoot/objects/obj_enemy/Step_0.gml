var _target_angle = point_direction(x, y, obj_player.x, obj_player.y)

//firing code
switch (laser_state) {
    case "tracking":
        laser_angle += angle_difference(_target_angle, laser_angle) * laser_track_rate
        laser_timer += 1
        if (laser_timer >= tracking_duration) {
            laser_state = "locked"
            laser_timer = 0
        }
        break

    case "locked":
        laser_timer += 1
        if (laser_timer >= lock_duration) {
            laser_state = "firing"
            laser_timer = 0
            kick_timer = kick_duration
        }
        break

    case "firing":
        laser_timer += 1
        if (!has_hit_player) {
            var _dx = lengthdir_x(1, laser_angle)
            var _dy = lengthdir_y(1, laser_angle)
            var _tx = (_dx != 0) ? (((_dx > 0) ? room_width : 0) - x) / _dx : infinity
            var _ty = (_dy != 0) ? (((_dy > 0) ? room_height : 0) - y) / _dy : infinity
            var _t = min(_tx, _ty)
            var _end_x = x + _dx * _t
            var _end_y = y + _dy * _t

            if (collision_line(x, y, _end_x, _end_y, obj_player, false, false)) {
                obj_player.hp -= laser_damage
                has_hit_player = true
            }
        }
        if (laser_timer >= fire_duration) {
            laser_state = "tracking"
            laser_timer = 0
            has_hit_player = false
        }
        break
}

laser_alpha = (laser_state == "firing") ? 1 : 0.3

//fire recoil
if (kick_timer > 0) {
    kick_timer -= 1
    var _kick_ratio = kick_timer / kick_duration
    image_xscale = 1 + kick_amount * _kick_ratio
    image_yscale = 1 - kick_amount * _kick_ratio * 0.5
} else {
    image_xscale = lerp(image_xscale, 1, 0.2)
    image_yscale = lerp(image_yscale, 1, 0.2)
}

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
                instance_destroy()
            }
        }
    }
}

//knockback systems

if (hit_cooldown > 0) {
    hit_cooldown -= 1
}


//preventing enemy from going into the wall
if (!place_meeting(x + knockback_x, y, obj_wall)) {
    x += knockback_x
} else {
    knockback_x = 0
}

if (!place_meeting(x, y + knockback_y, obj_wall)) {
    y += knockback_y
} else {
    knockback_y = 0
}

x = clamp(x, 0, room_width)
y = clamp(y, 0, room_height)

knockback_x *= knockback_friction
knockback_y *= knockback_friction

//squash and stretch
if (hit_squash_timer > 0) {
    hit_squash_timer -= 1
    var _hit_ratio = hit_squash_timer / hit_squash_duration
    image_xscale = 1 - hit_squash_amount * _hit_ratio
    image_yscale = 1 + hit_squash_amount * _hit_ratio
}

//visual damage flash like when characters flash white when hit
if (flash_timer > 0) {
    flash_timer -= 1
}