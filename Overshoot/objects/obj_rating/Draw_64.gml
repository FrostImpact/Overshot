if global.paused == false{	
	var _rating_x = 1274
	var _rating_y = 102
	var _final_scale = 0.8 * rating_scale

	draw_sprite_ext(spr_rating, image_index, _rating_x, _rating_y, _final_scale, _final_scale, rating_angle, c_white, 1)

	if (flash_alpha > 0) {
	    gpu_set_blendmode(bm_add)
	    draw_sprite_ext(spr_rating, image_index, _rating_x, _rating_y, _final_scale * 1.1, _final_scale * 1.1, rating_angle, c_white, flash_alpha)
	    gpu_set_blendmode(bm_normal)
	}

	var _timer_x = 1274
	var _timer_y = 180
	var _seconds = string(floor(room_time))
	var _pct = (starting_time > 0) ? (room_time / starting_time) : 0

	var _pulse = (_pct < 0.25) ? 1 + sin(current_time / 80) * 0.15 : 1
	var _draw_scale = timer_scale * _pulse
	var _timer_color = merge_color(c_red, make_color_rgb(255, 240, 190), _pct)

	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)

	draw_text_transformed_color(_timer_x + 3, _timer_y + 3, _seconds, _draw_scale, _draw_scale, 0, c_black, c_black, c_black, c_black, 0.6)
	draw_text_transformed_color(_timer_x, _timer_y, _seconds, _draw_scale, _draw_scale, 0, _timer_color, _timer_color, _timer_color, _timer_color, 1)

	if (popup_timer > 0) {
	    var _t = 1 - (popup_timer / popup_duration)
	    var _popup_y = _timer_y - 30 - (_t * 25)
	    var _popup_x = _timer_x + sin(_t * 10) * 4
	    var _popup_alpha = 1 - _t
	    var _popup_scale = 1 + (sin(_t * pi) * 0.4)
    
	    var _sign = (popup_value > 0) ? "+" : ""
	    var _popup_color = (popup_value > 0) ? c_lime : c_red
    
	    draw_set_color(c_black)
	    draw_set_alpha(_popup_alpha * 0.6)
	    draw_text_transformed(_popup_x + 3, _popup_y + 3, _sign + string(popup_value), _popup_scale, _popup_scale, 0)
    
	    draw_set_color(_popup_color)
	    draw_set_alpha(_popup_alpha)
	    draw_text_transformed(_popup_x, _popup_y, _sign + string(popup_value), _popup_scale, _popup_scale, 0)
    
	    draw_set_alpha(1)
	}

	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	draw_set_color(c_white)
}