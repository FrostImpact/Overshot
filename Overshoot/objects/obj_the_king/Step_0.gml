if (global.paused == false) {
    event_inherited();

    var gm = obj_game_manager;
    var g_spd = gm.game_speed;
    var px = obj_player.x;
    var py = obj_player.y;
    var cam_y = camera_get_view_y(view_camera[0]);

    if (state != 2 && state != 3 && state != 8) {
        if (place_meeting(x, y, obj_wall)) {
            for (var i = 1; i < 30; i++) {
                if (!place_meeting(x + i, y, obj_wall)) { x += i; break; }
                if (!place_meeting(x - i, y, obj_wall)) { x -= i; break; }
                if (!place_meeting(x, y + i, obj_wall)) { y += i; break; }
                if (!place_meeting(x, y - i, obj_wall)) { y -= i; break; }
            }
        }
        
        if (place_meeting(x, y, obj_player)) {
            var push_dir = point_direction(x, y, px, py);
            obj_player.x += lengthdir_x(5 * g_spd, push_dir);
            obj_player.y += lengthdir_y(5 * g_spd, push_dir);
        }
    }

    if (state == 0 || state == 1 || state == 5) {
        visual_angle = point_direction(x, y, px, py);
    }

    leap_cooldown = max(0, leap_cooldown - g_spd);
    laser_cooldown = max(0, laser_cooldown - g_spd);
    dash_cooldown = max(0, dash_cooldown - g_spd); 

    if (irandom(3) == 0) {
        part_particles_create(global.p_sys, x + random_range(-30, 30), y + random_range(-30, 30), global.p_spark, 1);
    }

    var base_recovery = 40;

    switch (state) {
        case 0:
            timer -= g_spd;
            if (timer <= 0) {
                var choices = [];
                if (leap_cooldown <= 0) array_push(choices, 1);
                if (laser_cooldown <= 0) array_push(choices, 5);
                if (dash_cooldown <= 0) array_push(choices, 7);

                if (array_length(choices) > 0) {
                    var attack = choices[irandom(array_length(choices) - 1)];
                    
                    if (attack == 1) {
                        state = 1;
                        timer = 30;
                        leap_cooldown = 300;
                        targ_x = px;
                        targ_y = py;
                        
                        var warn = instance_create_layer(targ_x, targ_y, layer, obj_king_warning);
                        warn.timer = 60;
                        warn.max_timer = 60;
                        warn.radius = 100;
                    } 
                    else if (attack == 5) {
                        state = 5;
                        timer = 50;
                        laser_cooldown = 400;
                    } 
                    else if (attack == 7) {
                        state = 7;
                        timer = 45;
                        dash_cooldown = 350;
                        dash_dir = point_direction(x, y, px, py);
                        visual_angle = dash_dir;
                    }
                } else {
                    timer = 15;
                }
            }
            break;

        case 1:
            timer -= g_spd;
            visual_xscale = lerp(visual_xscale, base_scale * 1.2, 0.1 * g_spd);
            visual_yscale = lerp(visual_yscale, base_scale * 0.8, 0.1 * g_spd);

            if (timer <= 0) {
                state = 2;
                z_spd = -55;
            }
            break;

        case 2:
            z_spd += 1.5 * g_spd;
            z_offset += z_spd * g_spd;
            visual_xscale = lerp(visual_xscale, base_scale * 0.8, 0.2 * g_spd);
            visual_yscale = lerp(visual_yscale, base_scale * 1.3, 0.2 * g_spd);

            if (z_offset < -600) {
                x = targ_x;
                y = targ_y;
                state = 3;
                z_spd = 5;
            }
            break;

        case 3:
            z_spd += 3.5 * g_spd;
            z_offset += z_spd * g_spd;
            visual_xscale = lerp(visual_xscale, base_scale * 0.85, 0.3 * g_spd);
            visual_yscale = lerp(visual_yscale, base_scale * 1.2, 0.3 * g_spd);

            if (z_offset >= 0) {
                z_offset = 0;
                state = 4;
                timer = 20;
                
                gm.boss_slow = true;
                part_particles_create(global.p_sys, x, y, global.p_spark, 60);

                if (point_distance(x, y, px, py) < 100) {
                    obj_player.hp -= 35;
                    var k_dir = point_direction(x, y, px, py);
                    obj_player.x += lengthdir_x(45, k_dir);
                    obj_player.y += lengthdir_y(45, k_dir);
                }
            }
            break;

        case 4:
            timer -= g_spd;
            visual_xscale = lerp(visual_xscale, base_scale * 1.3, 0.3 * g_spd);
            visual_yscale = lerp(visual_yscale, base_scale * 0.7, 0.3 * g_spd);

            if (timer <= 0) {
                gm.boss_slow = false;
                state = 0;
                timer = base_recovery;
            }
            break;

        case 5:
            timer -= g_spd;
            var p_dist = random_range(40, 80);
            var p_dir = random(360);
            part_particles_create(global.p_sys, x + lengthdir_x(p_dist, p_dir), y + lengthdir_y(p_dist, p_dir), global.p_spark, 1);

            if (timer <= 0) {
                state = 6;
                laser_start_angle = visual_angle;
                laser_sweep_progress = 0;
            }
            break;

        case 6:
            var sweep_speed = 2.5 * g_spd;
            laser_sweep_progress += sweep_speed;
            visual_angle = laser_start_angle + laser_sweep_progress;

            var l_len = max(room_width, room_height) * 1.5;

            for (var d = 0; d < l_len; d += 24) {
                var lx = x + lengthdir_x(d, visual_angle);
                var ly = y + lengthdir_y(d, visual_angle);
                
                if (irandom(3) == 0) {
                    part_particles_create(global.p_sys, lx, ly, global.p_spark, 1);
                }

                if (position_meeting(lx, ly, obj_player)) {
                    obj_player.hp -= 0.8 * g_spd;
                }
            }

            if (laser_sweep_progress >= 360) {
                visual_angle = laser_start_angle;
                state = 0;
                timer = base_recovery;
            }
            break;

        case 7:
            timer -= g_spd;
            visual_xscale = lerp(visual_xscale, base_scale * 1.15, 0.1 * g_spd);
            visual_yscale = lerp(visual_yscale, base_scale * 0.85, 0.1 * g_spd);

            if (timer <= 0) {
                state = 8;
                timer = 30;
                dash_curr_spd = 2 * g_spd;
                
                var dash_dist = 700;
                targ_x = x + lengthdir_x(dash_dist, dash_dir);
                targ_y = y + lengthdir_y(dash_dist, dash_dir);
            }
            break;

        case 8:
            timer -= g_spd;
            dash_curr_spd = min(42 * g_spd, dash_curr_spd + 2.5 * g_spd);

            visual_xscale = lerp(visual_xscale, base_scale * 0.75, 0.3 * g_spd);
            visual_yscale = lerp(visual_yscale, base_scale * 1.3, 0.3 * g_spd);

            var nx = x + lengthdir_x(dash_curr_spd, dash_dir);
            var ny = y + lengthdir_y(dash_curr_spd, dash_dir);

            var hit_wall = false;
            if (!place_meeting(nx, y, obj_wall)) x = nx; else hit_wall = true;
            if (!place_meeting(x, ny, obj_wall)) y = ny; else hit_wall = true;

            if (place_meeting(x, y, obj_player)) {
                obj_player.hp -= 25;
                var k_dir = dash_dir;
                obj_player.x += lengthdir_x(50, k_dir);
                obj_player.y += lengthdir_y(50, k_dir);
            }

            if (hit_wall || point_distance(x, y, targ_x, targ_y) < dash_curr_spd || timer <= 0) {
                state = 4;
                timer = 20;
                gm.boss_slow = true;
                part_particles_create(global.p_sys, x, y, global.p_spark, 40);
            }
            break;
    }

    var lerp_spd = clamp(0.2 * g_spd, 0, 1);
    visual_xscale = lerp(visual_xscale, base_scale, lerp_spd);
    visual_yscale = lerp(visual_yscale, base_scale, lerp_spd);
}