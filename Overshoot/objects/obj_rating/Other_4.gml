if (room != Test && room != Starting_Room) {
    
    // Create a dictionary matching room names to their ID and Time limits
    var _level_data = {
        rm_level_1: { level_id: 1, time: 120 },
        rm_level_2: { level_id: 2, time: 70 },
        rm_level_3: { level_id: 3, time: 70 },
        rm_level_4: { level_id: 4, time: 120 },
        rm_level_5: { level_id: 5, time: 150 },
        rm_level_6: { level_id: 6, time: 200 },
        rm_level_7: { level_id: 7, time: 250 },
        rm_level_8: { level_id: 8, time: 150 },
        rm_level_9: { level_id: 9, time: 160 },
        rm_boss:    { level_id: 0, time: 320 }
    };

    var _room_name = room_get_name(room);
    
    // Check if the current room exists in our data struct
    if (variable_struct_exists(_level_data, _room_name)) {
        
        // Grab the configuration for this specific room
        var _config = _level_data[$ _room_name];
        
        global.curr_room = _config.level_id;
        room_time_max = _config.time;
        
    } else {
        // Fallback if the room isn't in the list
        global.curr_room = 1;
        room_time_max = 60; 
    }

    room_time = room_time_max;
    starting_time = room_time;
}