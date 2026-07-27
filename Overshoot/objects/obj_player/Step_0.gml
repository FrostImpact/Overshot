if (hp > 0) {
    
    var game_speed = obj_game_manager.game_speed
    yspeed += gravity_force * game_speed
    xspeed = clamp(xspeed, -max_speed, max_speed)
    yspeed = clamp(yspeed, -max_speed, max_speed)

    if (mouse_check_button_pressed(mb_left)) {
        
        play_sound_scr("stretch")
        
        is_aiming = true
        aim_start_x = mouse_x
        aim_start_y = mouse_y
        
        aim_check = true
    }
    
    if (mouse_check_button_released(mb_left)) {
        aim_check = false
    }

    if (is_aiming && mouse_check_button_released(mb_left)) {
        
        play_sound_scr("release")
        
        is_aiming = false
        var _dx = aim_start_x - mouse_x
        var _dy = aim_start_y - mouse_y
        var _dist = point_distance(0, 0, _dx, _dy)
        var _launch_speed = min(_dist * launch_power_scale, max_launch_speed)
        var _dir = point_direction(0, 0, _dx, _dy)
        xspeed = lengthdir_x(_launch_speed, _dir)
        yspeed = lengthdir_y(_launch_speed, _dir)
       
        var time_penalty = -0.25
		
        with (obj_rating) {
            room_time += time_penalty
            popup_value = time_penalty
            popup_duration = 60
            popup_timer = popup_duration
        }
    }

    var _move_x = xspeed * game_speed
    var _move_y = yspeed * game_speed
    var _avg_speed = point_distance(0, 0, xspeed, yspeed)
    var _speed_ratio = clamp(_avg_speed / max_speed, 0, 1)
    
    if (_avg_speed > 0.1) {
        image_angle = point_direction(0, 0, xspeed, yspeed)
    }
    
    if (place_meeting(x + _move_x, y, obj_wall) || place_meeting(x + _move_x, y, obj_basic)) {
        
        impact_speed = _avg_speed
        
        with (obj_rating) {
            rating_angle = choose(-5, 5)
            rating_scale = 1.2
        }
        
        if (place_meeting(x + _move_x, y, obj_basic)) {
            var _enemy = instance_place(x + _move_x, y, obj_basic)
        }
        
        if (place_meeting(x + _move_x, y, obj_wall_hurt)) {
            hp -= 10
        }
        xspeed = -xspeed * bounce
        squash_timer = squash_duration * game_speed
        
    } else {
        x += _move_x
    }
    
    if (place_meeting(x, y+ _move_y, obj_wall) || place_meeting(x, y + _move_y, obj_basic) || place_meeting(x, y + yspeed, obj_ground)) {
        
        impact_speed = _avg_speed
        
        with (obj_rating) {
            rating_angle = choose(-10, 10)
            rating_scale = 1.2
        }
        
        if (place_meeting(x, y + _move_y, obj_basic)) {
            var _enemy = instance_place(x, _move_y, obj_basic)
        }
        
        if (place_meeting(x + _move_x, y, obj_wall_hurt)) {
            hp -= 10
        }
        
        if (place_meeting(x, y + _move_y, obj_wall_hurt)) {
            hp -= 10
        }
        if (place_meeting(x, y + _move_y, obj_ground)) {
            yspeed = -ground_launch_speed
            
        } else {
            yspeed = -yspeed * bounce
        }
        
        squash_timer = squash_duration
        
    } else {
        y += _move_y
    }

    var _target_xscale = 1
    var _target_yscale = 1

    if (squash_timer > 0) {
        squash_timer -= 1
        var _squash_ratio = squash_timer / squash_duration
        _target_xscale = 1 - squash_amount * _squash_ratio
        _target_yscale = 1 + squash_amount * _squash_ratio
    } else {
        _target_xscale = 1 + stretch_amount * _speed_ratio
        _target_yscale = 1 - stretch_amount * _speed_ratio * 0.5
    }

    image_xscale = lerp(image_xscale, _target_xscale, scale_lerp_speed * game_speed)
    image_yscale = lerp(image_yscale, _target_yscale, scale_lerp_speed * game_speed)

}