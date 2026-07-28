//temporary death manager
if (instance_exists(obj_player)) {
    
    if (obj_player.hp <= 0) {
		
		obj_player.image_speed = 0.5
      
        if (obj_player.sprite_index != spri_player_death) {
            obj_player.sprite_index = spri_player_death;
            obj_player.image_index = 0; 
           
        } 
     
        else {
          
            if (obj_player.image_index >= obj_player.image_number - 1) {
                room_restart();
            }
        }
        
    }
}
	

	



if (check = 0) {
	textbox_say(["Hello! Welcome to OVERSHOOT, a game where you... launch yourself at balls!",
				"Oh look, one of those dirty red scumbags...",
				"Do me a favour and... get rid of it.",
				"(Click and drag back your mouse to launch yourself)"])
	check = 1
}

//bullet time managers

if obj_player.aim_check == true {
    game_speed = 0.2
	
} else if boss_slow == true {
    game_speed = 0.5
	
} else {
    game_speed = 1
}


if game_speed < 1.0 { //black and white shaders
    layer_set_visible("FX_Bullet_Time", true)
} else {
    layer_set_visible("FX_Bullet_Time", false)
}

cam = view_camera[0]

target = 1

if instance_exists(obj_player) {
    if obj_player.aim_check == true {
        target = 0.95
    }
}

new_w = lerp(camera_get_view_width(cam), base_w * target, 0.1)
new_h = lerp(camera_get_view_height(cam), base_h * target, 0.1)

camera_set_view_size(cam, new_w, new_h)

cam_x = (room_width / 2) - (new_w / 2)
cam_y = (room_height / 2) - (new_h / 2)

camera_set_view_pos(cam, cam_x, cam_y)