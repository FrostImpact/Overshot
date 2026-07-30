if (global.game_ended == true) {
	
	instance_destroy(obj_player)
	instance_destroy(obj_game_manager)
	instance_destroy(obj_rating)
	instance_destroy(obj_level_manager)
	
	textbox_say([
            "Thank you for freeing us from the tyrant.", 
            "We can finally live in peace!"
        ], c_maroon, true, 60)
	
	if !(obj_text_box.state == TB_STATE.TYPING){
		
		bleh = true
    
		if (fade_alpha < 1) {
			fade_alpha += fade_speed
		} else {
			fade_complete = true
		}
    

    }
}