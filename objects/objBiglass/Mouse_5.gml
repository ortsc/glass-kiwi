if (place_meeting(x, y, objPlayer)) {
objPlayer.jump_moment_y = y
objPlayer.vsp += -15
alarm[0] = room_speed/30
}