#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
type = 0

sprite_fix_offset(16,32)

image_angle = 0
image_yscale = 10
y = 32
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    if instance_number(o_mario) > 0
        image_yscale = max(10,10 + ( y - o_mario.y )/32.0)
}
