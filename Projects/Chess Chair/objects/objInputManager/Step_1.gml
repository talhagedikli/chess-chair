if (active) 
{
	with (p1)
	{
		horizontalInput		= (keyboard_check(vk_right) - keyboard_check(vk_left));		// Will be -1, 0 or 1
		verticalInput		= (keyboard_check(vk_down) - keyboard_check(vk_up));		// Will be -1, 0 or 1

		keyRight			= keyboard_check(vk_right);
		keyLeft				= keyboard_check(vk_left);
		keyDown				= keyboard_check(vk_down);
		keyUp				= keyboard_check(vk_up);
		
		keyJump 			= keyboard_check(vk_space);	
		keyDashPressed		= keyboard_check_pressed(ord("Z"));
		keyRun				= keyboard_check(ord("B"));

		keyRightPressed 	= keyboard_check_pressed(vk_right);
		keyLeftPressed		= keyboard_check_pressed(vk_left);
		keyDownPressed		= keyboard_check_pressed(vk_down);
		keyUpPressed		= keyboard_check_pressed(vk_up);
	}
} 
else 
{

}
