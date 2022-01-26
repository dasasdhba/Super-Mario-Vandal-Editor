#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
pause = -1

velocity = 0
height = 64
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause && instance_number(o_water_surface_auto) > 0 && place_meeting(x,y,o_mario) && o_water_surface_auto.ytarget != height
{
    o_water_surface_auto.ytarget = height
    if velocity > 0
        o_water_surface_auto.velocity = velocity

    audio_sound_play("tide")
}
