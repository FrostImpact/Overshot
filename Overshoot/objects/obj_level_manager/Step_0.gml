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

if keyboard_check_pressed(ord("9"))
{
    room_goto(Level9)
	textbox_say(["level 9"], c_maroon, true, 60)
}

if keyboard_check_pressed(ord("T"))
{
    room_goto(Test)
	textbox_say(["Testing Level"], c_maroon, true, 60)
}

if keyboard_check_pressed(ord("M"))
{
    room_goto(Mini_Boss_Room)
	textbox_say(["Mini Boss level"], c_maroon, true, 60)
}