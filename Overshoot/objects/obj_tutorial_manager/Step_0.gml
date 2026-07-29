if (step<1)
{
	obj_text_box.advance_key=vk_enter;
}
else
{
	obj_text_box.advance_key=vk_space;
}


if (step==1)
{
	if (obj_basic.enemy_hp < 50)
	{
		step=2;
		
		textbox_advance();
		textbox_say(["Wow! You did it!"],c_maroon,true,60);
	}
}

if (keyboard_check(vk_backspace))
{
	textbox_advance();
	textbox_advance();
	textbox_advance();
	textbox_advance();
	textbox_advance();
	textbox_advance();
}

