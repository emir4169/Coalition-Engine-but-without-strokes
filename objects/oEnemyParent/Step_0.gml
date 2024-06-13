///@desc Turns, very trash, working on it
function end_turn() { __turn_has_ended = true; }

if !__died && state == BATTLE_STATE.IN_TURN && !__turn_has_ended && __enemy_in_battle {
	//Timer
	if start time++;
	if array_length(AttackFunctions) > current_turn AttackFunctions[current_turn]();
	else
	{
		current_turn--;
		end_turn();
	}
}

if ContainsDust
{
	if !surface_exists(__dust_surface) __dust_surface = surface_create(640, 480);
	if !__died && __is_dying && __death_time >= 1 + attack_end_time {
		//Dust height adding
		if dust_height < enemy_total_height {
			dust_height += enemy_total_height / dust_speed * 6;
		}
		for (var i = 0; i < dust_height * dust_amount / enemy_total_height; i += 3) {
			if dust_alpha[i] > 0 {
				dust_pos[i][0] += dust_displace[i][0];
				dust_pos[i][1] += dust_displace[i][1];
				dust_alpha[i] -= 1 / dust_life[i];
				if !__dust_being_drawn __dust_being_drawn = true;
			}
		}
	}
}

//Calculates the height and width of the enemy, then initalizes the dust particles (Will only run once, don't worry for lag)
if enemy_total_height == 0 || enemy_max_width == 0
{
	var i = 0;
	repeat(array_length(enemy_sprites))
	{
		enemy_total_height += sprite_get_height(enemy_sprites[i]) * enemy_sprite_scale[i][1];
		enemy_max_width = max(sprite_get_width(enemy_sprites[i]) * enemy_sprite_scale[i][0],
								enemy_max_width);
		++i;
	}

	//Particles aren't used because if a lot of particles are created then the CPU will be abused
	//And the dust amount is on average at least a couple hundred, so drawing in arrays are better
	if ContainsDust {
		dust_height = 0;
		dust_amount = enemy_total_height * enemy_max_width / 6;
		//Using array create functions to speed up loading time because it's easy to have over 2000 values in the arrays
		var _f = function()
		{
			var dust_speed = random_range(1, 3),
				dust_direction = random_range(55, 125);
			return [lengthdir_x(dust_speed, dust_direction),
					lengthdir_y(dust_speed, dust_direction)];
		}
		dust_displace = array_create_ext(dust_amount, _f);
		_f = function()
		{
			return irandom_range(60, 120);
		}
		dust_life = array_create_ext(dust_amount, _f);
		dust_alpha = array_create(dust_amount, 1);
		_f = function()
		{
			return random(360);
		}
		dust_angle = array_create_ext(dust_amount, _f);
		_f = function()
		{
			return random_range(1, -1);
		}
		dust_rotate = array_create_ext(dust_amount, _f);
		i = 0;
		repeat(dust_amount)
		{
			dust_pos[i] = [random_range(-enemy_max_width, enemy_max_width) / 2 + x,
						   y - enemy_total_height + (i * 6 / enemy_max_width)];
			i++;
		}
	}
}
wiggle_timer = wiggle ? wiggle_timer + 1 : 0;