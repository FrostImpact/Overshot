event_inherited()

image_angle = laser_angle

var game_speed = obj_game_manager.game_speed
var _target_angle = point_direction(x, y, obj_player.x, obj_player.y)

//firing state machine
switch (laser_state) {
    case "tracking":
        laser_angle += angle_difference(_target_angle, laser_angle) * laser_track_rate * game_speed
        laser_timer += 1 * game_speed
        if (laser_timer >= tracking_duration) {
            laser_state = "locked"
            laser_timer = 0
        }
        break
    case "locked":
        laser_timer += 1 * game_speed
        if (laser_timer >= lock_duration) {
            laser_state = "firing"
            laser_timer = 0
            kick_timer = kick_duration
        }
        break
    case "firing":
        laser_timer += 1 * game_speed
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
    kick_timer -= 1 * game_speed
    var _kick_ratio = kick_timer / kick_duration
    image_xscale = 1 + kick_amount * _kick_ratio
    image_yscale = 1 - kick_amount * _kick_ratio * 0.5
}