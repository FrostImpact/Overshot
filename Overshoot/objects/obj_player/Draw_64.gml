var _hp_ratio = clamp(hp / hp_max, 0, 1)

//draw_set_color(c_black)
//draw_rectangle(hp_bar_x - 2, hp_bar_y - 2, hp_bar_x + hp_bar_width + 2, hp_bar_y + hp_bar_height + 2, false)

draw_set_color(c_dkgray)
draw_rectangle(hp_bar_x, hp_bar_y, hp_bar_x + hp_bar_width, hp_bar_y + hp_bar_height, false)

draw_set_color(merge_color(c_orange, c_orange, _hp_ratio))
draw_rectangle(hp_bar_x, hp_bar_y, hp_bar_x + (hp_bar_width * _hp_ratio), hp_bar_y + hp_bar_height, false)

draw_set_color(c_white)
draw_set_halign(fa_left)
draw_set_valign(fa_middle)
draw_text(hp_bar_x + hp_bar_width + 10, hp_bar_y + hp_bar_height / 2, string(hp) + " / " + string(hp_max))