if (hp > 0) and (global.paused == false) {
    
//temporary solution to player getting stuck inside chrono
//i would like to improve the collision with obj_basic so that
//it is universal, but alas I cannot

    if (place_meeting(x, y, obj_basic)) {
        var _boss = instance_place(x, y, obj_basic)
        if (_boss != noone) {
            
            var _push_dir = point_direction(_boss.x, _boss.y, x, y)
            
            if (x == _boss.x && y == _boss.y) {
                _push_dir = random(360)
            }
            
            while (place_meeting(x, y, obj_basic)) {
                
                if (!place_meeting(x,y,obj_wall)){
                    x += lengthdir_x(1, _push_dir)
                    y += lengthdir_y(1, _push_dir)
                }
                
                break
            }
        }
    }
    
    
    var game_speed = obj_game_manager.game_speed
    yspeed += gravity_force * game_speed
    xspeed = clamp(xspeed, -max_speed, max_speed)
    yspeed = clamp(yspeed, -max_speed, max_speed)

    if (mouse_check_button_pressed(mb_left)) {
        play_sound_scr("stretch")
        
        aim_check = true
        
        aim_drag_x = 0
        aim_drag_y = 0
        
        window_mouse_set(window_get_width() / 2, window_get_height() / 2)

    }
    
    if (aim_check) {
        var _cx = window_get_width() / 2
        var _cy = window_get_height() / 2
			
        //aim_drag_x += _cx - window_mouse_get_x()
        //aim_drag_y += _cy - window_mouse_get_y()
		
		aim_drag_x -= window_mouse_get_delta_x();
        aim_drag_y -= window_mouse_get_delta_y();
        
        //window_mouse_set(_cx, _cy)
        
        if (mouse_check_button_released(mb_left)) {
            play_sound_scr("release")
			
            
            aim_check = false
            
            var _dist = point_distance(0, 0, aim_drag_x, aim_drag_y)
            var _launch_speed = min(_dist * launch_power_scale * 0.2, max_launch_speed)
            var _dir = point_direction(0, 0, aim_drag_x, aim_drag_y)
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
    }

    var _move_x = xspeed * game_speed * slow
    var _move_y = yspeed * game_speed * slow

    
    if slow < 1 {
        part_particles_create(global.p_sys, random_range(x + 5,x - 5), random_range(y + 5, y - 5), global.p_slime, 1);
    }
    
    var _avg_speed = point_distance(0, 0, xspeed, yspeed)
    var _speed_ratio = clamp(_avg_speed / max_speed, 0, 1)
    
    if (_avg_speed > 0.1) {
        visual_angle = point_direction(0, 0, xspeed, yspeed)
    }
    
    if (place_meeting(x + _move_x, y, obj_wall) || place_meeting(x + _move_x, y, obj_basic)) {
        var _sign_x = sign(_move_x)
        
        if (_sign_x != 0 && !place_meeting(x, y, obj_wall) && !place_meeting(x, y, obj_basic)) {
            while (!place_meeting(x + _sign_x, y, obj_wall) && !place_meeting(x + _sign_x, y, obj_basic)) {
                x += _sign_x
            }
        }
        
        impact_speed = abs(xspeed)
        
        with (obj_rating) {
            rating_angle = choose(-5, 5)
            rating_scale = 1.2
        }
        
        if (place_meeting(x + _sign_x, y, obj_basic)) {
            var _enemy = instance_place(x + _sign_x, y, obj_basic)
        }
        
        if (place_meeting(x + _sign_x, y, obj_wall_hurt)) {
            hp -= 10
        }
        
        xspeed = -xspeed * bounce
        
        if (impact_speed > 1) { 
            play_sound_scr("bounce") 
            squash_timer = squash_duration * game_speed
        }
        
    } else {
        x += _move_x
    }
    
    if (place_meeting(x, y + _move_y, obj_wall) || place_meeting(x, y + _move_y, obj_basic) || place_meeting(x, y + _move_y, obj_ground)) {
        var _sign_y = sign(_move_y)
        
        if (_sign_y != 0 && !place_meeting(x, y, obj_wall) && !place_meeting(x, y, obj_basic) && !place_meeting(x, y, obj_ground)) {
            while (!place_meeting(x, y + _sign_y, obj_wall) && !place_meeting(x, y + _sign_y, obj_basic) && !place_meeting(x, y + _sign_y, obj_ground)) {
                y += _sign_y
            }
        }
        
        impact_speed = abs(yspeed)
        
        with (obj_rating) {
            rating_angle = choose(-10, 10)
            rating_scale = 1.2
        }
        
        if (place_meeting(x, y + _sign_y, obj_basic)) {
            var _enemy = instance_place(x, y + _sign_y, obj_basic)
        }
        
        if (place_meeting(x, y + _sign_y, obj_wall_hurt)) {
            hp -= 10
        }
        
        if (place_meeting(x, y + _sign_y, obj_ground)) {
            yspeed = -ground_launch_speed
        } else {
            yspeed = -yspeed * bounce
        }
        
        if (impact_speed > 1) {
            play_sound_scr("bounce") 
            squash_timer = squash_duration * game_speed
        }
        
    } else {
        y += _move_y
    }

    var _target_xscale = 1
    var _target_yscale = 1
    
  
    var _on_ground = place_meeting(x, y + 2, obj_wall)

    if (squash_timer > 0) {
        
        squash_timer -= 1
        var _squash_ratio = squash_timer / squash_duration
        _target_xscale = 1 - squash_amount * _squash_ratio
        _target_yscale = 1 + squash_amount * _squash_ratio
        
    } else if (_on_ground && abs(yspeed) <= 1) {

        _target_xscale = 1
        _target_yscale = 1
    } else {

        _target_xscale = 1 + stretch_amount * _speed_ratio
        _target_yscale = 1 - stretch_amount * _speed_ratio * 0.5
    }
    
//more efficient to do this via draw sprite_ext 
//because doing it in step caused to have a bug
//where it would expand into a wall and get stuck

    visual_xscale = lerp(visual_xscale, _target_xscale, scale_lerp_speed * game_speed)
    visual_yscale = lerp(visual_yscale, _target_yscale, scale_lerp_speed * game_speed)
    
}