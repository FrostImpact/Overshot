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
	dir-=5;
}
else
{
	dir+=5;
}
xspeed=lengthdir_x(spe,dir);
yspeed=lengthdir_y(spe,dir);
x+=xspeed;
y+=yspeed;
time1+=delta_time/1000000;
if (time1>=3 || place_meeting(x,y,obj_player))
{
	if  (place_meeting(x,y,obj_player))
	{
		obj_player.hp-=0.1;
	}
	instance_destroy();
	//add animation later!!!!
}
image_angle=dir;