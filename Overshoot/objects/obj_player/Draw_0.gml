draw_sprite_ext(sprite_index, image_index, x, y, visual_xscale, visual_yscale, visual_angle, image_blend, image_alpha)

var _indicator_dir = point_direction(x, y, mouse_x, mouse_y)

if (aim_check) {
    _indicator_dir = point_direction(0, 0, aim_drag_x, aim_drag_y)
}

var _orbit_radius = 40
var _tri_center_x = x + lengthdir_x(_orbit_radius, _indicator_dir)
var _tri_center_y = y + lengthdir_y(_orbit_radius, _indicator_dir)

var _tip_x = _tri_center_x + lengthdir_x(8, _indicator_dir)
var _tip_y = _tri_center_y + lengthdir_y(8, _indicator_dir)
var _left_x = _tri_center_x + lengthdir_x(6, _indicator_dir + 120)
var _left_y = _tri_center_y + lengthdir_y(6, _indicator_dir + 120)
var _right_x = _tri_center_x + lengthdir_x(6, _indicator_dir - 120)
var _right_y = _tri_center_y + lengthdir_y(6, _indicator_dir - 120)

draw_set_color(c_white)
draw_set_alpha(0.7)
draw_triangle(_tip_x, _tip_y, _left_x, _left_y, _right_x, _right_y, false)
draw_set_alpha(1)

if (aim_check) {
    var _dist = point_distance(0, 0, aim_drag_x, aim_drag_y)

    var _launch_speed = min(_dist * launch_power_scale * 0.125, max_launch_speed)
    
    var _power_ratio = _launch_speed / max_launch_speed
    var _line_length = _launch_speed * 8

    var _end_x = x + lengthdir_x(_line_length, _indicator_dir)
    var _end_y = y + lengthdir_y(_line_length, _indicator_dir)

    var _line_color = merge_color(c_yellow, c_red, _power_ratio)

    draw_set_color(_line_color)
    draw_set_alpha(0.8)
    draw_line_width(x, y, _end_x, _end_y, 4)

    var _line_tip_x = _end_x + lengthdir_x(12, _indicator_dir)
    var _line_tip_y = _end_y + lengthdir_y(12, _indicator_dir)
    var _line_left_x = _end_x + lengthdir_x(8, _indicator_dir + 90)
    var _line_left_y = _end_y + lengthdir_y(8, _indicator_dir + 90)
    var _line_right_x = _end_x + lengthdir_x(8, _indicator_dir - 90)
    var _line_right_y = _end_y + lengthdir_y(8, _indicator_dir - 90)

    draw_set_alpha(1)
    draw_triangle(_line_tip_x, _line_tip_y, _line_left_x, _line_left_y, _line_right_x, _line_right_y, false)

    draw_set_color(c_white)
    draw_text(x - 20, y - 40, string(round(_launch_speed)))
}