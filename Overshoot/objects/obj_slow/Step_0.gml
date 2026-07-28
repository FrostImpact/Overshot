// Inherit the parent event
event_inherited();
t=delta_time/1000000;
cd+=t;
if (cd>=cd_total)
{
	cd=0;
	start_slow=true;
	player_x=obj_player.x;
	player_y=obj_player.y;
}

if (start_slow==true)
{
	slow+=t;
}

if (slow>cd_slow)
{
	slow=0;
	start_slow=false;
	if (point_distance(player_x,player_y,obj_player.x,obj_player.y)<=range)
	{
		slowing=true;
	}
}
if (slowing=true)
{
	slowed+=t;
	obj_player.x-=obj_player.xspeed*amount;
	obj_player.y-=obj_player.yspeed*amount;
}

if (slowed>slow_time)
{
	slowed=0;
	slowing=false;
}

