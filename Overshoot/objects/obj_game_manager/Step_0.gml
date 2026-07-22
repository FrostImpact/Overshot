//temporary death manager
if (obj_player.hp < 0){
	
	room_restart()
	
}

//bullet time 

if (obj_player.aim_check = true){
	game_speed = 0.2
}

else if (obj_player.aim_check = false){
	game_speed = 1
}


if (game_speed < 1.0) {

    layer_set_visible("FX_Bullet_Time", true);
} else {

    layer_set_visible("FX_Bullet_Time", false);
}