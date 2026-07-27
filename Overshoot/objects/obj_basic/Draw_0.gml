
image_blend = (flash_timer > 0) ? c_white : c_white
draw_self()

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