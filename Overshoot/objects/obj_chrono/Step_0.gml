event_inherited();

var gm = obj_game_manager;
var g_spd = gm.game_speed;
var px = obj_player.x;
var py = obj_player.y;

image_angle = point_direction(x, y, px, py);

shatter_cooldown = max(0, shatter_cooldown - g_spd);
special_cooldown = max(0, special_cooldown - g_spd);

if (obj_player.aim_check && shatter_cooldown <= 0) {
    aim_punish_timer++;
    
    if (aim_punish_timer > 90) {
        state = 5;
        timer = 60;
        aim_punish_timer = 0;
        shatter_cooldown = 600;
        
        obj_player.aim_check = false;
        gm.game_speed = 1;
        gm.boss_slow = false; 
        
        textbox_say(["You think you can slow down time against me?", "ME??!"], c_lime, true, 30);
       
	   instance_create_layer(0, 0, layer, obj_shatter);
        part_particles_create(global.p_sys, x, y, global.p_spark, 25);
    } else if (aim_punish_timer > 60) {
        part_particles_create(global.p_sys, x + random_range(-10, 10), y + random_range(-10, 10), global.p_spark, 1);
    }
} else {
    aim_punish_timer = max(0, aim_punish_timer - 0.5);
}

if (state != 6) {
    if (enemy_hp <= 0) {
        state = 6;
        gm.boss_slow = false; 
        textbox_say(["Impossible...", "My time... has run out..."], c_lime, true, 30);
    } else if (phase == 1 && enemy_hp <= enemy_max_hp * 0.2) {
        phase = 2;
        target_hp = enemy_hp + (enemy_max_hp * 0.1);
        state = 4;
        timer = 120;
        gm.boss_slow = false;
        textbox_say(["You really thought it would be that easy?", "Time is a construct...", "And I can always just REWIND!", "Let's speed things up!"], c_lime, true, 30);
    }
}

if (state == 1) {
    part_particles_create(global.p_sys, x + random_range(-15, 15), y + random_range(-15, 15), global.p_spark, 1);
} else if (state == 3) {
    part_type_orientation(global.p_trail, image_angle, image_angle, 0, 0, false);
    part_type_scale(global.p_trail, image_xscale, image_yscale);
    part_particles_create(global.p_sys, x, y, global.p_trail, 1);
}

var base_timer = (phase == 1) ? 25 : 18;
var spec_cooldown_set = (phase == 1) ? 300 : 200;

switch (state) {
    case 0:
        timer -= g_spd;
        if (timer <= 0) {
            if (special_cooldown <= 0 && choose(0, 1)) {
                var selected_attack = (phase == 2) ? choose(1, 2) : 1;
                special_cooldown = spec_cooldown_set;
                
                if (selected_attack == 1) {
                    state = 2;
                    timer = (phase == 1) ? 20 : 12;
                    
                    var dir = image_angle + random_range(-30, 30); // Reused image_angle
                    targ_x = x;
                    targ_y = y;
                                    
                    while (!place_meeting(targ_x, targ_y, obj_wall) && clamp(targ_x, 1, room_width - 1) == targ_x && clamp(targ_y, 1, room_height - 1) == targ_y) {
                        targ_x += lengthdir_x(16, dir);
                        targ_y += lengthdir_y(16, dir);
                    }
                    targ_x -= lengthdir_x(16, dir);
                    targ_y -= lengthdir_y(16, dir);
                } else {
                    state = 7;
                    timer = 25; 
                }
            } else {
                state = 1;
                timer = 15;
                targ_x = lengthdir_x(18, image_angle);
                targ_y = lengthdir_y(18, image_angle);
            }
        }
        break;

    case 1:
        var nx = x + targ_x * g_spd;
        var ny = y + targ_y * g_spd;
        
        if (!place_meeting(nx, y, obj_wall)) x = nx;
        if (!place_meeting(x, ny, obj_wall)) y = ny;
        
        timer -= g_spd;
        if (timer <= 0) {
            var knife = instance_create_layer(x, y, layer, obj_knife);
            knife.direction = image_angle; 
            knife.speed = 14 * g_spd;
            knife.image_angle = knife.direction;
            
            x -= lengthdir_x(8, knife.direction);
            y -= lengthdir_y(8, knife.direction);
            
            state = 0;
            timer = base_timer;
        }
        break;

    case 2:
        timer -= g_spd;
        x += random_range(-2, 2) * g_spd;
        y += random_range(-2, 2) * g_spd;
        
        if (timer <= 0) {
            state = 3;
            timer = (phase == 1) ? 12 : 8;
            gm.boss_slow = true;
            current_dash_speed = 0;
            part_particles_create(global.p_sys, x, y, global.p_spark, 15);
        }
        break;

    case 3:
        var dist = point_distance(x, y, targ_x, targ_y);
        var dir = point_direction(x, y, targ_x, targ_y);
       
        current_dash_speed = (dist > 150) ? min(current_dash_speed + (3.5 * g_spd), 45 * g_spd) : max(current_dash_speed * 0.75, 4 * g_spd);
        
        var spd = min(current_dash_speed, dist);
        var nx = x + lengthdir_x(spd, dir);
        var ny = y + lengthdir_y(spd, dir);
        
        var hit_wall = false;
        if (!place_meeting(nx, y, obj_wall)) x = nx; else hit_wall = true;
        if (!place_meeting(x, ny, obj_wall)) y = ny; else hit_wall = true;
        
        timer -= g_spd;
        if (timer <= 0) {
            var knife = instance_create_layer(x, y, layer, obj_knife);
            knife.direction = image_angle;
            knife.speed = 16 * g_spd;
            knife.image_angle = knife.direction;
            timer = (phase == 1) ? 6 : 4;
        }
        
        if (dist < 5 || hit_wall) {
            gm.boss_slow = false;
            state = 0;
            timer = base_timer;
            part_particles_create(global.p_sys, x, y, global.p_spark, 10);
        }
        break;

    case 4:
        timer -= g_spd;
        image_angle += (45 - (timer * 0.35)) * g_spd;
        
        var s_dist = 30 + (timer * 0.8);
        var s_dir = random(360);
        part_particles_create(global.p_sys, x + lengthdir_x(s_dist, s_dir), y + lengthdir_y(s_dist, s_dir), global.p_vortex, 1);
        
        if (enemy_hp < target_hp) enemy_hp += (target_hp - enemy_hp) * 0.05 * g_spd;
        
        if (timer <= 0) {
            image_angle = 0;
            enemy_hp = target_hp;
            state = 0;
            timer = base_timer;
            part_particles_create(global.p_sys, x, y, global.p_spark, 40);
        }
        break;

    case 5:
        if (--timer <= 0) {
            state = 0;
            timer = base_timer;
        }
        break;

    case 6: 
        current_dash_speed = 0;
        if (!instance_exists(obj_text_box)) instance_destroy();
        break;
        
    case 7:
        timer -= g_spd;
        image_angle += 25 * g_spd; 
        
        if (timer <= 0) {
            for (var i = 0; i < 360; i += 45) {
                var knife = instance_create_layer(x, y, layer, obj_knife);
                knife.direction = i;
                knife.speed = 10 * g_spd;
                knife.image_angle = i;
            }
            state = 0;
            timer = base_timer;
            part_particles_create(global.p_sys, x, y, global.p_spark, 30);
        }
        break;
}

var c_spd = point_distance(xprevious, yprevious, x, y);

var tx = (state == 4) ? 1.4 + dsin(current_time * 0.8) * 0.6 : 1 + (c_spd * 0.02);
var ty = (state == 4) ? 1.4 - dsin(current_time * 0.8) * 0.6 : 1 - (c_spd * 0.015);

var lerp_spd = clamp(0.4 * g_spd, 0, 1);
image_xscale = lerp(image_xscale, clamp(tx, 0.4, 2.5), lerp_spd);
image_yscale = lerp(image_yscale, clamp(ty, 0.4, 2.5), lerp_spd);