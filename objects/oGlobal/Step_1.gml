/// @description Global

//input_tick(); // Input handler, do not delete!

if keyboard_check(vk_escape)
{
	quit_timer++
	if quit_timer >= 60 game_end();
}
else
{
	quit_timer = quit_timer ? quit_timer-- : 0;
}

global.timer++;

if keyboard_check_pressed(vk_f2) {instance_destroy(oBulletParents); game_restart();}
if keyboard_check_pressed(vk_f4) { window_set_fullscreen(!window_get_fullscreen()) alarm[1] = 1}//Fullscreen
if keyboard_check_pressed(vk_f9) global.show_hitbox = !global.show_hitbox;
