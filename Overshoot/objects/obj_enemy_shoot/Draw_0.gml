<<<<<<< HEAD
draw_self();
image_blend = c_white

draw_self()

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


var _bar_width = 48
var _bar_height = 6
var _bar_x = x - _bar_width / 2
var _bar_y = y - sprite_height / 2 - 12
var _hp_ratio = clamp(enemy_hp / enemy_max_hp, 0, 1)

draw_set_color(c_black)
draw_rectangle(_bar_x - 1, _bar_y - 1, _bar_x + _bar_width + 1, _bar_y + _bar_height + 1, false)

draw_set_color(c_red)
draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_width, _bar_y + _bar_height, false)

draw_set_color(c_lime)
draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_width * _hp_ratio, _bar_y + _bar_height, false)

draw_set_color(c_white)
=======
// Inherit the parent event
event_inherited();
>>>>>>> 46d7e894695d6b030fc7074106d4d09e6e6e8d5e

