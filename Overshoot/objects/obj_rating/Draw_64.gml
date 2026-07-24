var _real_speed = point_distance(0, 0, obj_player.xspeed, obj_player.yspeed)
var _speed_shake = min(_real_speed * 0.3, 4)
var _shake_x = random_range(-0.2, 0.2) * _speed_shake
var _shake_y = random_range(-0.2, 0.2) * _speed_shake
draw_sprite_ext(spr_rating, image_index, 1274 + _shake_x, 102 + _shake_y, 0.8, 0.8, 0, c_white, 1)

var _timer_x = 1274
var _timer_y = 180
var _seconds = string(floor(room_time))
var _pct = (starting_time > 0) ? (room_time / starting_time) : 0

var _pulse = (_pct < 0.25) ? 1 + sin(current_time / 100) * 0.08 : 1
var _draw_scale = timer_scale * _pulse

var _timer_color = merge_color(c_red, make_color_rgb(255, 240, 190), _pct)

draw_set_font(f_pixolde)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)

draw_text_transformed_color(_timer_x + 2, _timer_y + 2, _seconds, _draw_scale, _draw_scale, 0, c_black, c_black, c_black, c_black, 0.6)
draw_text_transformed_color(_timer_x, _timer_y, _seconds, _draw_scale, _draw_scale, 0, _timer_color, _timer_color, _timer_color, _timer_color, 1)

if (popup_timer > 0) {
    var _t = 1 - (popup_timer / popup_duration)
    var _popup_y = _timer_y - 30 - (_t * 20)
    var _popup_alpha = 1 - _t
    var _sign = (popup_value > 0) ? "+" : ""
    var _popup_color = (popup_value > 0) ? c_lime : c_red

    draw_set_color(_popup_color)
    draw_set_alpha(_popup_alpha)
    draw_text(_timer_x, _popup_y, _sign + string(popup_value))
    draw_set_alpha(1)
}

draw_set_halign(fa_left)
draw_set_valign(fa_top)
draw_set_color(c_white)