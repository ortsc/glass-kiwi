vsp = vsp + grv
if (place_meeting(x,y+vsp,objWall))
{
    while (!place_meeting(x,y+sign(vsp),objWall)) {y = y + sign(vsp)}
    vsp = 0}
y = y + vsp

if (place_meeting(x,y,objWall))
{
if (x < objPlayer.x) {x +=1};
if (x > objPlayer.x) {x -= 1};
}