event_inherited()

var game_speed = obj_game_manager.game_speed

if phase == 1 and enemy_hp <= enemy_max_hp * 0.2 {
    phase = 2
    target_hp = enemy_hp + (enemy_max_hp * 0.1)
    state = 4
    timer = 120
    obj_game_manager.boss_slow = false
    textbox_say(["You really thought it would be that easy?", "Time is a construct...", "And I can always just REWIND!", "Let's speed things up!"])
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
    effect_create_above(ef_spark, x + random_range(-30, 30), y + random_range(-30, 30), 0, c_green)
    
    if enemy_hp < target_hp {
        enemy_hp += (target_hp - enemy_hp) * 0.05 * game_speed
    }
    
    if timer <= 0 {
        image_angle = 0
        enemy_hp = target_hp
        state = 0
        timer = base_timer
    }
}