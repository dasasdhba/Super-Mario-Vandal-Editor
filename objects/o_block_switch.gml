#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
pause = -1

sprite_fix_offset(16,16)

type = 0
celeste = false

if !place_meeting(x,y,o_switch_hidden)
    state = 1
else
    state = -1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    if state = -1 && type = 0
    {
        type = -1
        image_alpha = 0.5
    }

    if state = 1 && type = -1
    {
        if place_meeting(x,y,o_mario) && o_mario.pipe = 0
        {
            if !celeste
            {
                if !global.debug_inv
                    o_mario.death = true
                type = 0
                image_alpha = 1
            }
        }
        else
        {
            type = 0
            image_alpha = 1
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !out_of_frame()
    draw_self()
