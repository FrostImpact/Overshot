var _real_speed = point_distance(0, 0, obj_player.xspeed, obj_player.yspeed);
var _speed_shake = min(_real_speed * 0.3, 4);
var _shake_x = random_range(-0.2, 0.2) * (_speed_shake);
var _shake_y = random_range(-0.2, 0.2) * (_speed_shake);

draw_sprite_ext(spr_rating, 0, 1274 + _shake_x, 102 + _shake_y, 0.8, 0.8, 0, c_white, 1);

//draw_sprite_ext(spr_rating, 0, 1274, 102, 0.8, 0.8, 0, c_white, 1);

var _timer_x = 1274;
var _timer_y = 180; 

var _seconds = string(floor(room_time));

//draw_set_font()
draw_set_halign(fa_center);
draw_set_valign(fa_middle);


draw_set_color(c_blue);
draw_text(_timer_x + 2, _timer_y + 2, _seconds);


draw_set_color(make_color_rgb(255, 240, 190));
draw_text(_timer_x, _timer_y, _seconds);

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
