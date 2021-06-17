vsp = vsp + grv
if (place_meeting(x,y+vsp,objWall))
{
    while (!place_meeting(x,y+sign(vsp),objWall)) {y = y + sign(vsp)}
    vsp = 0}
y = y + vsp

if place_meeting(x+1,y, objPlayer) && (!place_meeting(x-1, y, objWall)) && objPlayer.image_yscale >= 1
{x-=1}
if place_meeting(x-1,y, objPlayer) && (!place_meeting(x+1, y, objWall)) && objPlayer.image_yscale >= 1
{x+=1}