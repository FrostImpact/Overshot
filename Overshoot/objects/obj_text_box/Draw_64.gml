if (box_visible == false) {
	exit
}

var _base_sw = sprite_get_width(spr_text_box)
var _sh      = sprite_get_height(spr_text_box)
var _sw      = _base_sw * box_scale_x
var _x = display_get_gui_width() / 2
var _y = display_get_gui_height() - 64

draw_sprite_stretched_ext(spr_text_box, 0, _x - (_sw / 2), _y - (_sh / 2), _sw, _sh, c_white, 1)

draw_set_color(c_maroon)
draw_set_halign(fa_left)
draw_set_valign(fa_top)

var _text_x = _x - (_sw / 2) + text_x_offset
var _text_y = _y - (_sh / 2) + text_y_offset
var _wrap_w = _sw - (text_x_offset * 2)

draw_text_ext(_text_x, _text_y, text_display, -1, _wrap_w)

if (state == TB_STATE.WAITING) {
    if ((current_time div 250) mod 2 == 0) {
        draw_text(_text_x + _wrap_w - 5, _y + (_sh / 2) - 32, "▼")
    }
}