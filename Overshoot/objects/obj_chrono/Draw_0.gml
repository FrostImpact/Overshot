image_blend = flash_timer > 0 ? c_white : c_white
draw_sprite_ext(sprite_index, image_index, x, y, visual_xscale, visual_yscale, visual_angle, image_blend, image_alpha);

if state == 2 or state == 3 {
    draw_set_color(c_ltgray)
    draw_line_width(x, y, targ_x, targ_y, 3)
    draw_circle(targ_x, targ_y, 4, false)
}

if (state == 8 || state == 9) {
    draw_set_color(c_ltgray);
    draw_set_alpha(0.7);
    
    var draw_x = x;
    var draw_y = y;
    
    // draws only places that havent been drawn before
    var start_idx = (state == 9) ? current_path_index : 0;
    
    for (var i = start_idx; i < array_length(path_points); i++) {
        var p_x = path_points[i].px;
        var p_y = path_points[i].py;
        draw_line_width(draw_x, draw_y, p_x, p_y, 3);
        draw_circle(p_x, p_y, 4, false);
        draw_x = p_x;
        draw_y = p_y;
    }
    
    draw_set_alpha(1);
}

if state == 0 or state == 1 {
    draw_set_color(c_red)
    draw_set_alpha(0.5)
    draw_line_width(x, y, obj_player.x, obj_player.y, 1)
    draw_set_alpha(1)
}