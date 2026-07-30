timer -= 1
if timer <= 0 {
    sprite_delete(surf_spr)
	
	if room == Starting_Room{
		
		room_goto(Level1)
		
	}
	
    instance_destroy()
}

for (var i = 0 ; i < 8 ; i += 1) {
    sx[i] += s_xspeed[i]
    sy[i] += s_yspeed[i]
    s_yspeed[i] += 0.3
}

