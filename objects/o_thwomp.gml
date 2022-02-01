#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_fix_offset(32,65)
image_speed = 0
image_index = 0
laugh_speed = 0.1
laugh_count = 6

instance_init()
physics_init()
phy_type = 2
gravity_state = -1
gravity_dir = image_angle+270
gravity_a_water = 0.5
gravity_d_water = 0.5
gravity_max = 25
gravity_max_water = 6

smash_range = 64
stop_time = 60
return_v = 1

xorigin = x
yorigin = y
state = 0

s_count = 0
l_count = 0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    //state = 0: ready
    if state = 0 && !out_of_frame(96) && instance_number(o_mario) > 0
    {
        var distance;
        if gravity_dir = 90 || gravity_dir = 270
            distance =  abs( o_mario.x-x )
        else
        {
            var k;
            k = 0-tand(gravity_dir)
            distance = abs( o_mario.y-y - k*(o_mario.x-x) )/sqrt(k*k+1)
        }

        if distance <= smash_range + sprite_width/2
        {
            state = 1
            gravity_state = 1
        }
    }

    //state = 2: stop
    if state = 2
    {
        s_count += 1
        if s_count >= stop_time
        {
            s_count = 0
            move_dir = gravity_dir + 180
            move_v = return_v
            state = 3
        }
    }

    physics_step()
    var hit_block;
    hit_block = gravity_hit_block_down()
    if hit_block
        gravity_state = 1

    //state = 1: falling
    if state = 1 && gravity_state = 0
    {
        state = 2
        gravity_state = -1
        audio_sound_play("boom")
        o_camera.shake = 7

        var i;
        for (i=0;i<=1;i+=1)
        {
            var b;
            b = instance_create(x+16*image_xscale*sind(gravity_dir)*(2*i-1),y+16*image_xscale*cosd(gravity_dir)*(2*i-1),o_boom)
            b.phy_type = phy_type
            b.image_xscale = image_xscale
            b.image_yscale = image_yscale
            with(b)
            {
                if !physics_place(x,y)
                    instance_destroy()
            }
        }

    }

    //state = 3: returning
    if state = 3
    {
        if move_v = 0
            state = 0
        else if x*cosd(move_dir) > xorigin*cosd(move_dir) || y*sind(move_dir) < yorigin*sind(move_dir)
        {
            x = xorigin
            y = yorigin
            move_v = 0
            state = 0
        }
    }

    var hurt_flag;
    hurt_flag = hurt_mario()

    //laugh
    if hurt_flag && l_count = 0
    {
        l_count = 1
        audio_sound_play("thwomp")
    }

    if l_count = 0
    {
        image_speed = 0
        image_index = 0
    }
    else
    {
        var laugh;
        laugh = image_play(1,2,laugh_speed)
        if laugh
            l_count += 1

        if l_count > laugh_count
            l_count = 0
    }

    //fall
    var f_height;
    f_height = sprite_height + 256
    if ( ( gravity_dir >= 225 && gravity_dir <= 315 ) && y >= room_height + f_height )
    || ( ( gravity_dir >= 45 && gravity_dir <= 135 ) && y <= 0 - f_height )
    || ( ( gravity_dir >= 135 && gravity_dir <= 225 ) && x <= 0 - f_height )
    || ( ( gravity_dir >= 315 || gravity_dir <= 45 ) && x >= room_width + f_height )
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
