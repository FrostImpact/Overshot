display_hp = lerp(display_hp, enemy_hp, 0.1)

var gui_w = display_get_gui_width()
var bar_width = 400
var bar_height = 20
var bar_x = (gui_w - bar_width) / 2
var bar_y = 40
var hp_ratio = clamp(display_hp / enemy_max_hp, 0, 1)
var hp_color = phase == 1 ? c_lime : c_fuchsia

draw_set_halign(fa_center)
draw_set_color(c_lime)
draw_text(gui_w / 2, bar_y - 20, "CHRONO")
draw_set_halign(fa_left)


draw_set_color(c_gray)
draw_rectangle(bar_x, bar_y, bar_x + bar_width, bar_y + bar_height, false)

draw_set_color(hp_color)
draw_rectangle(bar_x, bar_y, bar_x + bar_width * hp_ratio, bar_y + bar_height, false)

draw_set_color(c_white)