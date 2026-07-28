// Inherit the parent event
event_inherited();
if (start_slow==true)
{
	draw_circle(player_x,player_y,range,true);
	draw_circle(player_x,player_y,range*slow/cd_slow,false);
}

