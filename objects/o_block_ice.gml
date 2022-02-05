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
scores = 100

destroy = false
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    if destroy
    {
        audio_sound_play("ice_break")
        var f;
        f = instance_create(x+4, y+4, o_ice_fragment)
        f.image_xscale = image_xscale
        f.image_yscale = image_yscale
        f.image_angle = image_angle
        f.gravity_dir = image_angle-90
        f.move_dir = image_angle
        f.gravity_v = -7
        f.move_v = 4

        f = instance_create(x-4, y+4, o_ice_fragment)
        f.image_xscale = image_xscale
        f.image_yscale = image_yscale
        f.image_angle = image_angle
        f.gravity_dir = image_angle-90
        f.move_dir = image_angle
        f.gravity_v = -7
        f.move_v = -4

        f = instance_create(x+4, y-4, o_ice_fragment)
        f.image_xscale = image_xscale
        f.image_yscale = image_yscale
        f.image_angle = image_angle
        f.gravity_dir = image_angle-90
        f.move_dir = image_angle
        f.gravity_v = -8
        f.move_v = 2

        f = instance_create(x-4, y-4, o_ice_fragment)
        f.image_xscale = image_xscale
        f.image_yscale = image_yscale
        f.image_angle = image_angle
        f.gravity_dir = image_angle-90
        f.move_dir = image_angle
        f.gravity_v = -8
        f.move_v = -2

        global.scores += scores
        instance_destroy()
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
