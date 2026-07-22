draw_self()

if (is_aiming) {
    var _dx = aim_start_x - mouse_x
    var _dy = aim_start_y - mouse_y
    var _dist = point_distance(0, 0, _dx, _dy)

    var _launch_speed = min(_dist * launch_power_scale, max_launch_speed)
    var _dir = point_direction(0, 0, _dx, _dy)

    var _power_ratio = _launch_speed / max_launch_speed
    var _line_length = _launch_speed * 8

    var _end_x = x + lengthdir_x(_line_length, _dir)
    var _end_y = y + lengthdir_y(_line_length, _dir)

    var _line_color = merge_color(c_yellow, c_red, _power_ratio)

    draw_set_color(_line_color)
    draw_set_alpha(0.8)
    draw_line_width(x, y, _end_x, _end_y, 4)

    draw_set_alpha(1)
    draw_circle(_end_x, _end_y, 6, false)

    draw_set_color(c_white)
    draw_text(x - 20, y - 40, string(round(_launch_speed)))

    draw_set_alpha(1)
    draw_set_color(c_white)
}

