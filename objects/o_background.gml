#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
pause = -1

bg = 0

//view link
view = 0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause && ( ( view = 0 && place_meeting(x, y, o_mario) ) || view = 2 ) && global.background != bg
{
    background_clear()
    global.background = bg
}

if view = 2
    view = 1
