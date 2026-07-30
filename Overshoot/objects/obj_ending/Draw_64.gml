if (global.game_ended == true) {
    
	if bleh == true{
	    draw_set_alpha(fade_alpha)
	    draw_set_color(c_black)
	    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false)
    
	    draw_set_alpha(1) 
    
	    if (fade_complete == true) {
	        draw_set_color(c_white)
	        draw_set_halign(fa_center)
	        draw_set_valign(fa_middle)
        
	        var _center_x = display_get_gui_width() / 2
	        var _center_y = display_get_gui_height() / 2
        
	        draw_text(_center_x, _center_y - 64, "Congratulations, you won! Thank you for playing - Harrison & Ethan")
        
	        draw_set_halign(fa_left)
	        draw_set_valign(fa_top)
	    }
	}
}