#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_user(0)
turn = false
def_bump = -1

sprite_fix_offset(16,31)
image_speed = 0.1

instance_init()
physics_init()
gravity_place = false
gravity_state = 1
gravity_a = 0.2
gravity_d = 0.2
move_place = false

dir = -1

scores = 100
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    physics_step()

    //get direction
    if move_dir = 180
        dir = -1
    else
        dir = 1

    //attacked
    event_user(1)

    if atk > 0
    {
        if atk < 5
        {
            var s;
            s = instance_create((bbox_left+bbox_right)/2, min(bbox_top,bbox_bottom), o_score)
            s.scores = scores
        }

        var death;
        death = instance_create(x, y, o_enemy_death)
        death.sprite_index = sprite_index
        death.image_angle = image_angle
        death.image_xscale = dir*image_xscale
        death.image_yscale = image_yscale
        death.yflip = true
        death.gravity_dir = gravity_dir

        if atk != 1 && atk != 5 && atk != 6
            audio_sound_play("kick_1")

        instance_destroy()
    }

    //fall
    if gravity_v > 0 && y >= room_height + 64
        instance_destroy()

}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !out_of_frame()
    draw_self_scale(dir*image_xscale,image_yscale)
