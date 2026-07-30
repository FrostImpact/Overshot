if (global.paused == false) {
    timer += 0.05
    y = start_y + sin(timer) * 10
	
	image_index += image_speed
	
    if (image_index >= image_number) {
        image_index = 0
		
	}
}

if (place_meeting(x,y,obj_player))
{
	global.clear+=1;
}
