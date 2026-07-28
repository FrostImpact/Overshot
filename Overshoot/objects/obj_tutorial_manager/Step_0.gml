if (step<1)
{
	obj_text_box.advance_key=vk_enter;
}
else
{
	obj_text_box.advance_key=vk_space;
}

if (step==0)
{
	if (obj_player.xspeed>0)
	{
		step=1;
		textbox_advance();
		textbox_say(["Now,launch yourself against your enemy!Yes,the red ball!"],c_maroon,false,60);
		textbox_advance();

	}
}
if (step==1)
{
	if (obj_basic.enemy_hp<50)
	{
		step=2;
		textbox_advance();
		textbox_say(["Wow! You did it!"],c_maroon,true,60);
	}
}

