#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
physics_init()

image_speed = 1

gravity_place = false
gravity_v = -5
gravity_a = 0.2
gravity_d = 0.2
gravity_max = 0
move_state = -1

coin = 1
scores = 200
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    if coin > 0
    {
        global.coin += coin
        coin = 0
    }

    if image_index = 21
    {
        var s;
        s = instance_create((bbox_left+bbox_right)/2, (bbox_top+bbox_bottom)/2, o_score)
        s.scores = scores

        instance_destroy()
    }

    physics_step()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !out_of_frame()
    draw_self()
