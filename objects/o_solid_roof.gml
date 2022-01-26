#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
type = 0

sprite_fix_offset(0,31)

image_angle = 0
image_yscale = 10
y = 31
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    if instance_number(o_mario) > 0
        image_yscale = min(10,10 + ( y - o_mario.y )/32.0)
}
