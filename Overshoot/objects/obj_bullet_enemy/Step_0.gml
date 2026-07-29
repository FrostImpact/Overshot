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
xspeed=lengthdir_x(spe,dir);
yspeed=lengthdir_y(spe,dir);
x+=xspeed;
y+=yspeed;
time1+=delta_time/1000000;
if (time1>=3)
{
	instance_destroy();
	//add animation later!!!!
}
image_angle=dir;

if (place_meeting(x,y,obj_player))
{
	obj_player.hp-=5;
	instance_destroy();
}

if (!instance_exists(obj_enemy_shoot))
{
	instance_destroy();
}

if (place_meeting(x,y,obj_wall))
{
	instance_destroy();
}
