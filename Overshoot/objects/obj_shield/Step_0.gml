var _target_dir = point_direction(x, y, obj_player.x, obj_player.y);

if (dir >= 360) {
    dir -= 360;
}
if (dir < 0) {
    dir += 360;
}

if ((dir > _target_dir && dir - _target_dir < 180) || (dir < _target_dir && _target_dir - dir > 180)) {
    dir -= 1;
} else {
    dir += 1;
}

image_angle = dir;

if (hit_cooldown <= 0) {
    var _hit = false;
    var _enemy_id = id;

    with (obj_player) {
        if (place_meeting(x + xspeed, y, _enemy_id) || place_meeting(x, y + yspeed, _enemy_id)) {
            _hit = true;
        }
    }

    if (_hit) {
        if (abs(angle_difference(dir, _target_dir)) <= 50) {
            obj_player.xspeed *= -1;
            obj_player.yspeed *= -1;
            obj_player.hp -= 10;
            
            hit_cooldown = hit_cooldown_duration;
        } else {
            var _player_speed = point_distance(0, 0, obj_player.xspeed, obj_player.yspeed);
            var _damage = _player_speed * damage_scale;
            
            if (_damage <= 0.5) {
                hit_cooldown = hit_cooldown_duration;
            }
        }
    }
}

event_inherited();