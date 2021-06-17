if(global.inv <= 3) && (place_meeting(x - 15, y, objPlayer)){
global.inv += 1
instance_destroy(id)
}
else if(global.inv <= 3) && (place_meeting(x + 15, y, objPlayer)){
global.inv += 1
instance_destroy(id)
}