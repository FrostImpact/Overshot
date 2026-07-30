if keyboard_check_pressed(ord("1"))
{
    room_goto(Level1)
	textbox_say(["Level 1"], c_maroon, false, 60)
	
}

if keyboard_check_pressed(ord("2"))
{
    room_goto(Level2)
	textbox_say(["Level 2"], c_maroon, true, 60)
}

if keyboard_check_pressed(ord("3"))
{
    room_goto(Level3)
	textbox_say(["Level 3"], c_maroon, true, 60)
}

if keyboard_check_pressed(ord("4"))
{
    room_goto(Level4)
	textbox_say(["Level 4"], c_maroon, true, 60)
}

if keyboard_check_pressed(ord("5"))
{
    room_goto(Level5)
	textbox_say(["Level 2"], c_maroon, true, 60)
}

if keyboard_check_pressed(ord("6"))
{
    room_goto(Level6)
	textbox_say(["Level 3"], c_maroon, true, 60)
}

if keyboard_check_pressed(ord("8"))
{
    room_goto(Level8)
	textbox_say(["Level 4"], c_maroon, true, 60)
}

if keyboard_check_pressed(ord("9"))
{
    room_goto(Level9)
	textbox_say(["level 9"], c_maroon, true, 60)
}

if keyboard_check_pressed(ord("B"))
{
    room_goto(Level0)
	textbox_say(["Boss Level"], c_maroon, true, 60)
}

if keyboard_check_pressed(ord("T"))
{
    room_goto(Test)
	textbox_say(["Testing Level"], c_maroon, true, 60)
}

if keyboard_check_pressed(ord("7"))
{
    room_goto(Level7)
	textbox_say(["Mini Boss level"], c_maroon, true, 60)
}

if keyboard_check_pressed(ord("S"))
{
    room_goto(Starting_Room)
}

show_debug_message(room);


var _clear = !(object_exists(obj_basic)||object_exists(obj_enemy_shoot)||object_exists(obj_laser)||object_exists(obj_shield)||object_exists(obj_slow)||object_exists(obj_the_king)||object_exists(obj_chrono));


if (room==Level1 && global.clear>=1)
	{
		room_goto(Level2);
		global.clear=0;
		textbox_say(["level 2"], c_maroon, true, 60)
	}
if (room==Level2 && global.clear>=2)
	{
		room_goto(Level3);
		global.clear=0;
		textbox_say(["level 3"], c_maroon, true, 60)
	}
if (room==Level3 && global.clear>=1)
	{
		room_goto(Level4);
		global.clear=0;
		textbox_say(["level 4"], c_maroon, true, 60)
	}
if (room==Level4 && global.clear>=2)
	{
		room_goto(Level5);
		global.clear=0;
		textbox_say(["level 5"], c_maroon, true, 60)
	}
if (room==Level5 && global.clear>=1)
	{
		room_goto(Level6);
		global.clear=0;
		textbox_say(["level 6"], c_maroon, true, 60)
	}
if (room==Level6 && _clear)
	{
		room_goto(Level7);
		global.clear=0;
		textbox_say(["Mini Boss level"], c_maroon, true, 60)
	}
if (room==Level7 && global.clear>=1)
	{
		room_goto(Level8);
		global.clear=0;
		textbox_say(["level 8"], c_maroon, true, 60)
	}
if (room==Level8 && global.clear>=1)
	{
		room_goto(Level9);
		global.clear=0;
		textbox_say(["level 9"], c_maroon, true, 60)
	}
if (room==Level9 && global.clear>=4)
	{
		room_goto(Level0);
		global.clear=0;
		textbox_say(["Boss level"], c_maroon, true, 60)
	}




