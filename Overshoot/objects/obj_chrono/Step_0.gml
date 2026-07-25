event_inherited()

var game_speed = obj_game_manager.game_speed

if enemy_hp <= 0 and state != 6 {
    state = 6
    timer = 120
    obj_game_manager.game_speed = 1
    obj_game_manager.boss_slow = false
    
    textbox_say(["Impossible...", "My time...", "Is up...!"], true, 35)
}

if shatter_cooldown > 0 { shatter_cooldown -= 1 * game_speed }

if obj_player.aim_check == true and state != 6 {
    if shatter_cooldown <= 0 {
        aim_punish_timer += 1
        if aim_punish_timer > 90 { 
            state = 5
            timer = 60
            aim_punish_timer = 0
            shatter_cooldown = 600
            
            obj_player.aim_check = false
            obj_game_manager.game_speed = 1
            
            textbox_say(["You think you can slow down time against me?","ME??!"], true, 30)
            
            instance_create_layer(0, 0, layer, obj_shatter)
        }
    }
} else {
    if aim_punish_timer > 0 { aim_punish_timer -= 0.5 }
}

if phase == 1 and enemy_hp <= enemy_max_hp * 0.2 and state != 6 {
    phase = 2
    target_hp = enemy_hp + (enemy_max_hp * 0.1)
    state = 4
    timer = 120
    obj_game_manager.boss_slow = false
    textbox_say(["You really thought it would be that easy?", "Time is a construct...", "And I can always just REWIND!", "Let's speed things up!"], true, 30)
}

if special_cooldown > 0 {
    special_cooldown -= 1 * game_speed
}

if state == 1 {
    effect_create_below(ef_flare, x, y, 0, c_lime)
} else if state == 3 {
    effect_create_below(ef_ring, x, y, 0, c_lime)
}

var base_timer = phase == 1 ? 25 : 10
var spec_cooldown_set = phase == 1 ? 300 : 120

if state == 0 {
    timer -= 1 * game_speed
    if timer <= 0 {
        if special_cooldown <= 0 and choose(0, 1) == 1 {
            state = 2
            timer = phase == 1 ? 20 : 10
            special_cooldown = spec_cooldown_set
            var dir = point_direction(x, y, obj_player.x, obj_player.y) + random_range(-30, 30)
            targ_x = x
            targ_y = y
            while !place_meeting(targ_x, targ_y, obj_wall) and targ_x > 0 and targ_x < room_width and targ_y > 0 and targ_y < room_height {
                targ_x += lengthdir_x(16, dir)
                targ_y += lengthdir_y(16, dir)
            }
            targ_x -= lengthdir_x(16, dir)
            targ_y -= lengthdir_y(16, dir)
        } else {
            state = 1
            timer = 15
            var dir = point_direction(x, y, obj_player.x, obj_player.y)
            targ_x = lengthdir_x(18, dir)
            targ_y = lengthdir_y(18, dir)
        }
    }
} else if state == 1 {
    var next_x = x + targ_x * game_speed
    var next_y = y + targ_y * game_speed
    
    if !place_meeting(next_x, y, obj_wall) { x = next_x }
    if !place_meeting(x, next_y, obj_wall) { y = next_y }
    
    timer -= 1 * game_speed
    
    if timer <= 0 {
        var knife = instance_create_layer(x, y, layer, obj_knife)
        knife.direction = point_direction(x, y, obj_player.x, obj_player.y)
        knife.speed = 14 * game_speed
        knife.image_angle = knife.direction
        state = 0
        timer = base_timer
    }
} else if state == 2 {
    timer -= 1 * game_speed
    if timer <= 0 {
        state = 3
        timer = phase == 1 ? 12 : 6
        obj_game_manager.boss_slow = true
    }
} else if state == 3 {
    var dist = point_distance(x, y, targ_x, targ_y)
    var dir = point_direction(x, y, targ_x, targ_y)
    var spd = min(24 * game_speed, dist)
    
    var next_x = x + lengthdir_x(spd, dir)
    var next_y = y + lengthdir_y(spd, dir)
    
    var hit_wall = false
    if !place_meeting(next_x, y, obj_wall) { x = next_x } else { hit_wall = true }
    if !place_meeting(x, next_y, obj_wall) { y = next_y } else { hit_wall = true }
    
    timer -= 1
    
    if timer <= 0 {
        var knife = instance_create_layer(x, y, layer, obj_knife)
        knife.direction = point_direction(x, y, obj_player.x, obj_player.y)
        knife.speed = 16 * game_speed
        knife.image_angle = knife.direction
        timer = phase == 1 ? 12 : 6
    }
    
    if dist < 5 or hit_wall {
        obj_game_manager.boss_slow = false
        state = 0
        timer = base_timer
    }
} else if state == 4 {
    timer -= 1 * game_speed
    image_angle += 15 * game_speed
    effect_create_above(ef_ring, x + random_range(-30, 30), y + random_range(-30, 30), 0, c_lime)
    
    if enemy_hp < target_hp {
        enemy_hp += (target_hp - enemy_hp) * 0.05 * game_speed
    }
    
    if timer <= 0 {
        image_angle = 0
        enemy_hp = target_hp
        state = 0
        timer = base_timer
    }
} else if state == 5 {
    timer -= 1 
    if timer <= 0 {
        state = 0
        timer = base_timer
    }
} else if state == 6 {
    timer -= 1
    
    x += random_range(-3, 3)
    y += random_range(-3, 3)
    
    effect_create_above(ef_spark, x + random_range(-20, 20), y + random_range(-20, 20), 1, c_lime)
    effect_create_above(ef_flare, x + random_range(-30, 30), y + random_range(-30, 30), 0, c_white)
    
    if timer <= 0 {
        effect_create_above(ef_explosion, x, y, 2, c_lime)
        effect_create_above(ef_explosion, x + 30, y - 20, 1, c_white)
        effect_create_above(ef_explosion, x - 30, y + 20, 1, c_lime)
        instance_destroy()
    }
}