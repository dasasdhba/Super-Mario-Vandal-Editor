#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed = 0

var s;
s = instance_create(x+2,y+1,o_solid)
s.image_xscale = (29*image_xscale - 2)/32.0
s.image_yscale = (32*image_yscale - 2)/32.0

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

    hurt_mario()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !out_of_frame()
    draw_self()
