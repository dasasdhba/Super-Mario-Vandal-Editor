#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed = 0
instance_init()
pause = -1

count = 0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    count += 0.7
    if count <= 6.5
        image_index = count
    else
        image_index = 6
    if count >= 32.5
        count = 0

    if ( place_meeting_round(x+1,y,o_mario) || place_meeting_round(x-1,y,o_mario) || place_meeting_round(x,y+1,o_mario) || place_meeting_round(x,y-1,o_mario) ) && !o_mario.invincible && o_mario.pipe = 0
        o_mario.hurt = o_mario.hurt_time
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !out_of_frame()
    draw_self()
