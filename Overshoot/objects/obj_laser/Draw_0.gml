event_inherited() 

var _dx = lengthdir_x(1, laser_angle)
var _dy = lengthdir_y(1, laser_angle)
var _tx = (_dx != 0) ? (((_dx > 0) ? room_width : 0) - x) / _dx : infinity
var _ty = (_dy != 0) ? (((_dy > 0) ? room_height : 0) - y) / _dy : infinity
var _t = min(_tx, _ty)
var _end_x = x + _dx * _t
var _end_y = y + _dy * _t

var _firing = (laser_state == "firing")
var _fire_ratio = _firing ? (laser_timer / fire_duration) : 0
var _width = _firing ? lerp(3, 14, _fire_ratio) : 3

if (_firing) {
    draw_set_color($4040ED)
    draw_set_alpha(laser_alpha * 0.25)
    draw_line_width(x, y, _end_x, _end_y, _width + 12)
}

draw_set_color($4040ED)
draw_set_alpha(laser_alpha)
draw_line_width(x, y, _end_x, _end_y, _width)
draw_set_alpha(1)
draw_set_color(c_white)