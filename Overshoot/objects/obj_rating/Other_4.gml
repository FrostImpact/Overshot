//getting room number

if room != Starting_Room {
	var _room_name = room_get_name(room)
	var _last_char = string_char_at(_room_name, string_length(_room_name))
}


//lv0 is the boss level
//last time is boss level time
room_times = [120,60,60,60,60,60,60,60,60]

global.curr_room = real(_last_char)

if global.curr_room = 0{
		
	//room_time_max = 60
	//room_time = room_time_max
	//starting_time = room_time
	
	//last time is boss level time
	//room_times = [60,60,60,60,60,60,60,60,60,60]
	
	room_time_max = room_times[-1]
}

if global.curr_room = 1{
	
	return
}

else {
	
	room_time_max = room_times[global.curr_room - 2]
	
}

room_time = room_time_max
starting_time = room_time