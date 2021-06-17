#region Get input
randomize()
if (death == false){
key_left = keyboard_check(ord("A"))
key_right = keyboard_check(ord("D"))
key_left_run = keyboard_check(ord("A"))
key_right_run= keyboard_check(ord("D"))
key_glind = keyboard_check(vk_space)
key_jump = keyboard_check_pressed(vk_space)
}
#endregion
#region Can I glind
if (key_glind) && (!place_meeting(x,y+1,objWall)) {
    gliding = true
	if !audio_is_playing(flappy) {
	audio_play_sound(flappy, 2, true);
}
}
else {
    gliding = false
	audio_stop_sound(flappy)
}
#endregion
#region Calculate Movement
var move = key_right - key_left

hsp = move * walksp;

vsp = vsp + grv
#endregion
#region rotate
if (key_left){
	gliding_idle = spr_player_glide
}
else if (key_right){
	gliding_idle = spr_player_glide_r
}
if (gliding){
    sprite_index = gliding_idle;
	if (gliding_idle == spr_player_glide){
		idle = spr_player_idle
	}
	if (gliding_idle == spr_player_glide_r){
		idle = spr_player_idle_r
	}
}
else if (key_left_run){
	sprite_index = spr_player_run
	idle = spr_player_idle
}
else if (key_right_run){
	sprite_index = spr_player_run_r
	idle = spr_player_idle_r
}
else {
	if (death = false){
		sprite_index = idle
	}
}
#endregion
#region Making Gliding Work And Setting Vsp Limit To -10 and 10
vsp = clamp(vsp, -10, 10 - gliding * 6);
#endregion
#region Doing Jump
if (place_meeting(x,y+1,objWall)) && (key_jump) {
    jump_moment_y = y
    vsp = jump;
}
#endregion
#region X Collison
if (place_meeting(x+hsp,y,objWall))
{
    while (!place_meeting(x+sign(hsp),y,objWall)){
        x = x + sign(hsp)
    }
    hsp = 0
}

x = x + hsp
#endregion
#region Y Collision
if (place_meeting(x,y+vsp,objWall))
{
    while (!place_meeting(x,y+sign(vsp),objWall)){
        y = y + sign(vsp)
    }
	jump_after_y = y
	moment_hp = global.hp
	if (vsp > 4) && (jump_moment_y - jump_after_y <= -64){
		audio_play_sound(glass_break, 5, false);
		fall = true
		alarm[0] = room_speed / 2
		global.hp -= vsp
		global.hp -= frac(global.hp)
		difference_hp = moment_hp - global.hp
		difference_hp = difference_hp / 2
		difference_hp -= frac(difference_hp)
		// make jump high
		jump += (jump * 0.2) * difference_hp
		// Make it smaller
		before_it_x = image_xscale
		before_it_y = image_yscale
		image_yscale -= 0.2 * difference_hp
		image_xscale = image_yscale;
		if (image_yscale < 0) {image_yscale = 0};
		if (image_xscale < 0) {image_xscale = 0};
		// generate glass
		while (difference_hp != 0){
			instance_create_layer(x+irandom_range(-125, 125), y, "Instances_1", objGlass)
			difference_hp -= 1
			}
		}
		else {
			fall = false
	}
	
    vsp = 0
}

y = y + vsp
#endregion
#region Restart And Debug
if (keyboard_check(ord("R"))) {
    room_restart()
}
#endregion
#region death
if image_xscale = 0 && image_yscale = 0 {
	death = true
	sprite_index = spr_player_death
	image_xscale = before_it_x
	image_yscale = before_it_y
	alarm[1] = room_speed - 2
}
#endregion