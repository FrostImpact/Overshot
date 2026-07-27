event_inherited()

image_angle = point_direction(x, y, obj_player.x, obj_player.y)
var game_speed = obj_game_manager.game_speed

if (shatter_cooldown > 0) shatter_cooldown -= 1 * game_speed
if (special_cooldown > 0) special_cooldown -= 1 * game_speed

if (obj_player.aim_check) {
    if (shatter_cooldown <= 0) {
        aim_punish_timer += 1
        
        if (aim_punish_timer > 60) {
            part_particles_create(global.p_sys, x + random_range(-10, 10), y + random_range(-10, 10), global.p_spark, 1)
        }
        
        if (aim_punish_timer > 90) {
            state = 5
            timer = 60
            aim_punish_timer = 0
            shatter_cooldown = 600
            
            obj_player.aim_check = false
            obj_game_manager.game_speed = 1
            obj_game_manager.boss_slow = false 
            
            textbox_say(["You think you can slow down time against me?", "ME??!"], c_lime, true, 30)
            instance_create_layer(0, 0, layer, obj_shatter)
            
            part_particles_create(global.p_sys, x, y, global.p_spark, 25)
        }
    }
} else {
    if (aim_punish_timer > 0) aim_punish_timer -= 0.5
}

if (enemy_hp <= 0 && state != 6) {
    state = 6
    obj_game_manager.boss_slow = false 
    textbox_say(["Impossible...", "My time... has run out..."], c_lime, true, 30)
}

if (phase == 1 && enemy_hp <= enemy_max_hp * 0.2 && state != 6) {
    phase = 2
    target_hp = enemy_hp + (enemy_max_hp * 0.1)
    state = 4
    timer = 120
    obj_game_manager.boss_slow = false
    textbox_say(["You really thought it would be that easy?", "Time is a construct...", "And I can always just REWIND!", "Let's speed things up!"], c_lime, true, 30)
}

if (state == 1) {
    part_particles_create(global.p_sys, x + random_range(-15, 15), y + random_range(-15, 15), global.p_spark, 1)
} else if (state == 3) {
    part_type_orientation(global.p_trail, image_angle, image_angle, 0, 0, false)
    part_type_scale(global.p_trail, image_xscale, image_yscale)
    part_particles_create(global.p_sys, x, y, global.p_trail, 1)
}

var base_timer = (phase == 1) ? 25 : 18
var spec_cooldown_set = (phase == 1) ? 300 : 200

switch (state) {
    case 0:
        timer -= 1 * game_speed
        if (timer <= 0) {
            if (special_cooldown <= 0 && choose(0, 1) == 1) {
                
                var selected_attack = 1; 
                if (phase == 2) selected_attack = choose(1, 2);
                
                if (selected_attack == 1) {
                    state = 2
                    timer = (phase == 1) ? 20 : 12
                    special_cooldown = spec_cooldown_set
                    
                    var dir = point_direction(x, y, obj_player.x, obj_player.y) + random_range(-30, 30)
                    targ_x = x
                    targ_y = y
                    
                    while (!place_meeting(targ_x, targ_y, obj_wall) && targ_x > 0 && targ_x < room_width && targ_y > 0 && targ_y < room_height) {
                        targ_x += lengthdir_x(16, dir)
                        targ_y += lengthdir_y(16, dir)
                    }
                    targ_x -= lengthdir_x(16, dir)
                    targ_y -= lengthdir_y(16, dir)
                } else {
                  
                    state = 7
                    timer = 25 
                    special_cooldown = spec_cooldown_set
                }
                
            } else {
                state = 1
                timer = 15
                var dir = point_direction(x, y, obj_player.x, obj_player.y)
                targ_x = lengthdir_x(18, dir)
                targ_y = lengthdir_y(18, dir)
            }
        }
        break

    case 1:
        var next_x = x + targ_x * game_speed
        var next_y = y + targ_y * game_speed
        
        if (!place_meeting(next_x, y, obj_wall)) x = next_x
        if (!place_meeting(x, next_y, obj_wall)) y = next_y
        
        timer -= 1 * game_speed
        
        if (timer <= 0) {
            var knife = instance_create_layer(x, y, layer, obj_knife)
            knife.direction = point_direction(x, y, obj_player.x, obj_player.y)
            knife.speed = 14 * game_speed
            knife.image_angle = knife.direction
            state = 0
            timer = base_timer
            
            x -= lengthdir_x(8, knife.direction)
            y -= lengthdir_y(8, knife.direction)
        }
        break

    case 2:
        timer -= 1 * game_speed
        x += random_range(-2, 2) * game_speed
        y += random_range(-2, 2) * game_speed
        
        if (timer <= 0) {
            state = 3
            timer = (phase == 1) ? 12 : 8
            obj_game_manager.boss_slow = true
            current_dash_speed = 0
            
            part_particles_create(global.p_sys, x, y, global.p_spark, 15)
        }
        break

    case 3:
        var dist = point_distance(x, y, targ_x, targ_y)
        var dir = point_direction(x, y, targ_x, targ_y)
        
        if (!variable_instance_exists(id, "current_dash_speed")) current_dash_speed = 0
        
        if (dist > 150) {
            current_dash_speed = min(current_dash_speed + (3.5 * game_speed), 45 * game_speed)
        } else {
            current_dash_speed = max(current_dash_speed * 0.75, 4 * game_speed)
        }
        
        var spd = min(current_dash_speed, dist)
        
        var next_x = x + lengthdir_x(spd, dir)
        var next_y = y + lengthdir_y(spd, dir)
        
        var hit_wall = false
        if (!place_meeting(next_x, y, obj_wall)) {
            x = next_x
        } else {
            hit_wall = true
        }
        
        if (!place_meeting(x, next_y, obj_wall)) {
            y = next_y
        } else {
            hit_wall = true
        }
        
        timer -= 1 * game_speed
        
        if (timer <= 0) {
            var knife = instance_create_layer(x, y, layer, obj_knife)
            knife.direction = point_direction(x, y, obj_player.x, obj_player.y)
            knife.speed = 16 * game_speed
            knife.image_angle = knife.direction
            timer = (phase == 1) ? 6 : 4
        }
        
        if (dist < 5 || hit_wall) {
            obj_game_manager.boss_slow = false
            state = 0
            timer = base_timer
            part_particles_create(global.p_sys, x, y, global.p_spark, 10)
        }
        break

    case 4:
        timer -= 1 * game_speed
        image_angle += (45 - (timer * 0.35)) * game_speed
        
        var spawn_dist = 30 + (timer * 0.8)
        var spawn_dir = random(360)
        part_particles_create(global.p_sys, x + lengthdir_x(spawn_dist, spawn_dir), y + lengthdir_y(spawn_dist, spawn_dir), global.p_vortex, 1)
        
        if (enemy_hp < target_hp) {
            enemy_hp += (target_hp - enemy_hp) * 0.05 * game_speed
        }
        
        if (timer <= 0) {
            image_angle = 0
            enemy_hp = target_hp
            state = 0
            timer = base_timer
            part_particles_create(global.p_sys, x, y, global.p_spark, 40)
        }
        break

    case 5:
        timer -= 1 
        if (timer <= 0) {
            state = 0
            timer = base_timer
        }
        break

    case 6: 
        current_dash_speed = 0
        
        if (!instance_exists(obj_text_box)) {
            instance_destroy()
        }
        break
        
    case 7:
        timer -= 1 * game_speed;
        image_angle += 25 * game_speed; 
        
        if (timer <= 0) {
            for (var i = 0; i < 360; i += 45) {
                var knife = instance_create_layer(x, y, layer, obj_knife)
                knife.direction = i
                knife.speed = 10 * game_speed
                knife.image_angle = knife.direction
            }
            state = 0
            timer = base_timer
            part_particles_create(global.p_sys, x, y, global.p_spark, 30)
        }
        break
}

var current_speed = point_distance(xprevious, yprevious, x, y)

var target_xscale = 1 + (current_speed * 0.02)
var target_yscale = 1 - (current_speed * 0.015)

if (state == 4) {
    target_xscale = 1.4 + dsin(current_time * 0.8) * 0.6
    target_yscale = 1.4 - dsin(current_time * 0.8) * 0.6
}

target_xscale = clamp(target_xscale, 0.4, 2.5)
target_yscale = clamp(target_yscale, 0.4, 2.5)

var lerp_speed = clamp(0.4 * game_speed, 0, 1)
image_xscale = lerp(image_xscale, target_xscale, lerp_speed)
image_yscale = lerp(image_yscale, target_yscale, lerp_speed)