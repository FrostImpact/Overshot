//turn to player in nearest direction
player=point_direction(x,y,obj_player.x,obj_player.y);
if (dir>=360)
{
	dir-=360;
}
if (dir<0)
{
	dir+=360;
}
if ((dir>player && dir-player<180)||(dir<player && player-dir>180))
{
	dir-=1;
}
else
{
	dir+=1;
}

image_angle=dir;

//copied enemy hurt code
if (hit_cooldown <= 0) {
    var _hit = false
    var _enemy_id = id

    with (obj_player) {
        if (place_meeting(x + xspeed, y, _enemy_id) || place_meeting(x, y + yspeed, _enemy_id)) {
            _hit = true
        }
    }

    if (_hit) {
        var _player_speed = point_distance(0, 0, obj_player.xspeed, obj_player.yspeed)
        var _damage = _player_speed * damage_scale
		
		if (dir-50<player && dir+50>player)
		{
			obj_player.xspeed=obj_player.xspeed*-1;
			obj_player.yspeed=obj_player.yspeed*-1;
			obj_player.hp-=10;
		}

        if (_damage > 0.5 && !(dir-50<player && dir+50>player)) {
            enemy_hp -= _damage
            hit_cooldown = hit_cooldown_duration

            var _knock_dir = point_direction(obj_player.x, obj_player.y, x, y)
            knockback_x = lengthdir_x(_player_speed * knockback_force, _knock_dir)
            knockback_y = lengthdir_y(_player_speed * knockback_force, _knock_dir)

            hit_squash_timer = hit_squash_duration
            flash_timer = flash_duration

            if (enemy_hp <= 0) {
                instance_destroy()
            }
        }
    }
}

//knockback systems

if (hit_cooldown > 0) {
    hit_cooldown -= 1
}


//preventing enemy from going into the wall
if (!place_meeting(x + knockback_x, y, obj_wall)) {
    x += knockback_x
} else {
    knockback_x = 0
}

if (!place_meeting(x, y + knockback_y, obj_wall)) {
    y += knockback_y
} else {
    knockback_y = 0
}

x = clamp(x, 0, room_width)
y = clamp(y, 0, room_height)

knockback_x *= knockback_friction
knockback_y *= knockback_friction

//squash and stretch
if (hit_squash_timer > 0) {
    hit_squash_timer -= 1
    var _hit_ratio = hit_squash_timer / hit_squash_duration
    image_xscale = 1 - hit_squash_amount * _hit_ratio
    image_yscale = 1 + hit_squash_amount * _hit_ratio
}

//visual damage flash like when characters flash white when hit
if (flash_timer > 0) {
    flash_timer -= 1
}