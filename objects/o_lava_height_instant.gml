#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
pause = -1

height = 64

//view link
view = 0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause && instance_number(o_lava_auto) > 0 && ( ( view = 0 && place_meeting(x, y, o_mario) ) || view = 2 ) && o_lava_auto.y != height
{
    if view = 2
        view = 1

    o_lava_auto.y = height
    o_lava_auto.ytarget = height
}
