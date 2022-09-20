//Data
enemy_name = "";
enemy_act = ["","","","",""];
enemy_act_text = ["","","","",""];
enemy_hp_max = 100;
enemy_hp = 100;
_enemy_hp = 100;
enemy_draw_hp_bar = 1;
enemy_defense = 1;
enemy_in_battle = true;
is_boss = false;
Exp_Give = 100;
Gold_Give = 100;

//Temp var
enemy_sprites = [spr_ink];
enemy_sprite_index = [0];
enemy_sprite_scale =
[
[1,1]
];
enemy_total_height = 0;
enemy_max_width = 0
for (var i = 0, n = array_length(enemy_sprites); i < n; ++i)
{
	enemy_total_height += sprite_get_height(enemy_sprites[i]);
	var m = sprite_get_width(enemy_sprites[i]);
	if m > enemy_max_width enemy_max_width = m;
}
enemy_sprite_pos =
[
[x, y]
];

//Dusts
dust_height = 0;
dust_amount = enemy_total_height * enemy_max_width;
for (var i = 0; i < dust_amount; i += 6)
{
    dust_pos[i] = [random_range(-enemy_max_width,enemy_max_width) / 2 + x,
				   round(y - enemy_total_height + (i / enemy_max_width))];
	dust_direction[i] = random_range(55,125);
	dust_speed[i] = random_range(1, 3);
	dust_displace[i] = [lengthdir_x(dust_speed[i], dust_direction[i]),
						lengthdir_y(dust_speed[i], dust_direction[i])];
	dust_life[i] = random_range(60, 120);
	dust_alpha[i] = 1;
}
dust_speed = 30;
dust_surface = surface_create(640, 480);
dust_being_drawn = false;

//Dialogs
is_dialog = 0;
dialog_size = [20, 65, 0, 190]; // UDLR
dialog_size[3] = 80;
dialog_dir = DIR.LEFT;
function dialog_init()
{
	dialog = "[c_black][/f][font_sans]";
	dialog += "ashivbudk wfbl;kjfzsh jfdbf kkasjbd.[delay,1000][shake]idk shake[/shake]";
	text_writer = scribble(dialog)
		.wrap(dialog_size[2]+dialog_size[3]-10, dialog_size[0]+dialog_size[1]-10)
	if text_writer.get_page() != 0 text_writer.page(0);
}
dialog_init();
dialog_text_typist = scribble_typist()
	.in(0.5, 0)
	.sound_per_char(snd_txtSans, 1, 1," ^!.?,:/\\|*")

//Under Attack
is_being_attacked = false;
is_dodge = false;
dodge_to = choose(-150, 150);
attack_time = 0;
attack_end_time = 60;
draw_damage = false;
damage_y = y - enemy_total_height - 20;
damage = 49;
damage_color = c_red;
bar_width = 120;
bar_retract_speed = 0.6;

//Death
death_time = 0;
is_dying = false;
died = false;

//Spare
enemy_is_spareable = true;
is_being_spared = false;
spare_end_begin_turn = false;
is_spared = false;


