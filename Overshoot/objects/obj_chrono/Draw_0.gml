image_blend = flash_timer > 0 ? c_white : c_white
draw_self()

if state == 2 or state == 3 {
    draw_set_color(c_ltgray)
    draw_line_width(x, y, targ_x, targ_y, 3)
    draw_circle(targ_x, targ_y, 4, false)
}

if state == 0 or state == 1 {
    draw_set_color(c_red)
    draw_set_alpha(0.5)
    draw_line_width(x, y, obj_player.x, obj_player.y, 1)
    draw_set_alpha(1)
}