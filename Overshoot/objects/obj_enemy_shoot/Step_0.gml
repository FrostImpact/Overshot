event_inherited();

time1 += delta_time / 1000000;

if (time1 >= 0.1) {
    time1 -= 0.1;
    instance_create_depth(x, y, 0, obj_bullet_enemy);
}

var _target_dir = point_direction(x, y, obj_player.x, obj_player.y);

if (dir >= 360) {
    dir -= 360;
}
if (dir < 0) {
    dir += 360;
}

if ((dir > _target_dir && dir - _target_dir < 180) || (dir < _target_dir && _target_dir - dir > 180)) {
    dir -= 1.5;
} else {
    dir += 1.5;
}

image_angle = dir;