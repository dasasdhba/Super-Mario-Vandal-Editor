#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
pause = -1
type = 0

sprite_index = s_cannon
sprite_fix_offset(16,16)
dir = image_angle + 90

launch_time_first = 25
launch_time = 175
launch_time_random = 150
launch_range = 64

launch_count = 0
launch_random = 0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause && !out_of_frame(32)
{
    var count;
    count = true
    if launch_range > 0 && instance_number(o_mario) > 0
    {
        var distance;
        if dir = 90 || dir = 270
            distance =  abs( o_mario.x-x )
        else
        {
            var k;
            k = 0-tand(dir)
            distance = abs( o_mario.y-y - k*(o_mario.x-x) )/sqrt(k*k+1)
        }

        if distance <= launch_range + sprite_width/2
            count = false
    }

    if count
    {
        var launch;
        launch = false

        launch_count += 1
        if launch_time_first > 0
        {
            if launch_count >= launch_time_first
            {
                launch_count = 0
                launch_time_first = -1
                launch_random = irandom(launch_time_random)
                launch = true
            }
        }
        else if launch_count >= launch_time + launch_random
        {
            launch_count = 0
            launch_random = irandom(launch_time_random)
            launch = true
        }
    }

    if launch
    {
        launch = false
        audio_sound_play("bullet_follow")

        var bullet,b_dir;
        bullet = instance_create(x,y,o_bullet_follow)
        bullet.x = x
        bullet.y = y
        bullet.depth = depth + 1
        bullet.image_xscale = image_xscale
        bullet.image_yscale = image_yscale
        bullet.activate = true
        if abs(sind(dir)) >= abs(cosd(dir))
        {
            if x*sign(sind(dir)) <= o_mario.x*sign(sind(dir))
                b_dir = -1
            else
                b_dir = 1
        }
        else
        {
            if y*sign(cosd(dir)) <= o_mario.y*sign(cosd(dir))
                b_dir = -1
            else
                b_dir = 1
        }
        bullet.dir = dir + 90*b_dir

        var bx,by,boom;
        bx = x + 16*cosd(dir + 90*b_dir)*abs(image_xscale)
        by = y - 16*sind(dir + 90*b_dir)*abs(image_yscale)
        boom = instance_create(bx,by,o_boom)
        boom.image_xscale = image_xscale
        boom.image_yscale = image_yscale

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
