#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
physics_init()

image_speed = 0

gravtiy_state = -1
move_place = false

alpha_v = 0.1
scale_v = 0.1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    physics_step()

    image_alpha -= alpha_v
    image_xscale -= scale_v
    image_yscale = image_xscale

    if image_alpha <= 0 || image_xscale <= 0
        instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !out_of_frame()
    draw_self()
