#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
moving_init()
sprite_fix_offset(sprite_get_width(sprite_index)/2,sprite_get_height(sprite_index)/2)

type = 1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
    moving_step()
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if stand_n > 0
{
    var i;
    for(i=0;i<stand_n;i+=1)
    {
        if dx != 0
            stand_id[i].gravity_fix_vx += dx - stand_id[i].gravity_fix_vx
        if dy != 0
            stand_id[i].gravity_fix_vy += dy - stand_id[i].gravity_fix_vy
    }
    stand_n = 0
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !out_of_frame()
    draw_self()
