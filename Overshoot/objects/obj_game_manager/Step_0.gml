//temporary death manager
if (obj_player.hp < 0){
	
	room_restart()
	
}

//bullet time managers

if (obj_player.aim_check == true){
	game_speed = 0.2
}

else if (obj_player.aim_check == false){
	game_speed = 1
}


if (game_speed < 1.0) { //for black and white shader

    layer_set_visible("FX_Bullet_Time", true)
} else {

    layer_set_visible("FX_Bullet_Time", false)
}



//zoom in camera during bulletimte
cam = view_camera[0]

target = obj_player.aim_check ? 0.9 : 1

new_w = lerp(camera_get_view_width(cam), base_w * target, 0.1)
new_h = lerp(camera_get_view_height(cam), base_h * target, 0.1)

camera_set_view_size(cam, new_w, new_h)

//zooms onto the player (should only work during bullet time but is bugged rn)
camera_set_view_pos(cam, obj_player.x - new_w / 2, obj_player.y - new_h / 2)