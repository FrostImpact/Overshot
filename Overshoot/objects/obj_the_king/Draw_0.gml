if (global.paused == false){


//laser attack inidicator

	if (state == 5) {
	    var l_len = max(room_width, room_height) * 1.5;
	    var lx_end = x + lengthdir_x(l_len, visual_angle);
	    var ly_end = y + lengthdir_y(l_len, visual_angle);

	    var flash_alpha = (dsin(current_time * 2.5) + 1) * 0.4 + 0.2;
	    draw_set_alpha(flash_alpha);
	    draw_set_color(c_red);
	    draw_line_width(x, y, lx_end, ly_end, 12);
	    draw_set_alpha(1);
	}

//laser attack 

	if (state == 6) {
	    var l_len = max(room_width, room_height) * 1.5;
	    var lx_end = x + lengthdir_x(l_len, visual_angle);
	    var ly_end = y + lengthdir_y(l_len, visual_angle);

	    draw_line_width_color(x, y, lx_end, ly_end, 48, c_orange, c_yellow);
	    draw_line_width_color(x, y, lx_end, ly_end, 20, c_yellow, c_white);
	}

	//dash attack indicator

	if (state == 7) {
	    var dash_len = 700;
	    var dash_width = 90;
    
	    var flash_alpha = (dsin(current_time * 2.5) + 1) * 0.4 + 0.15;
	    draw_set_alpha(flash_alpha);
	    draw_set_color(c_red);
    
	    var dx = lengthdir_x(1, dash_dir);
	    var dy = lengthdir_y(1, dash_dir);
    
	    var px_ortho = lengthdir_x(dash_width / 2, dash_dir + 90);
	    var py_ortho = lengthdir_y(dash_width / 2, dash_dir + 90);
    
	    var x1 = x + px_ortho;
	    var y1 = y + py_ortho;
	    var x2 = x - px_ortho;
	    var y2 = y - py_ortho;
	    var x3 = x2 + dx * dash_len;
	    var y3 = y2 + dy * dash_len;
	    var x4 = x1 + dx * dash_len;
	    var y4 = y1 + dy * dash_len;
    
	    draw_primitive_begin(pr_trianglefan);
	    draw_vertex(x1, y1);
	    draw_vertex(x2, y2);
	    draw_vertex(x3, y3);
	    draw_vertex(x4, y4);
	    draw_primitive_end();
    
	    draw_set_alpha(1);
	}
	
}

var yellow_tone = (dsin(current_time * 0.3) + 1) * 0.5;
var current_color = merge_color(c_orange, c_yellow, yellow_tone);

draw_sprite_ext(sprite_index, image_index, x, y + z_offset, visual_xscale, visual_yscale, visual_angle, current_color, image_alpha);