#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
physics_init()

phy_slope = 0

gravity_a = 0.4
gravity_d = 0.4
gravity_v = -5

move_v = 2.125
move_mode = 2

count = 0
bounce = false
explode = false
bubble = 0

if physics_place(x,y,1)
{
    bounce = true
    gravity_place = false
    move_place = false
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    physics_step()
    gravity_hit_block_up()
    gravity_hit_block_down()
    move_hit_block()

    if !gravity_place && !explode
    {
        var block;
        do
        {
            block = instance_place_round(x,y,o_block)
            if block
            {
                if !block.hit
                {
                    block.hit = true
                    if block.hidden
                    {
                        block.hidden = false
                        type = 0
                        visible = true
                    }

                    bounce = true
                }
                instance_ignore(block)
            }
        }
        until( !block )
        instance_recover()

    }

    if count < 3
    {
        if !gravity_place && gravity_v > 0 && !physics_place(x,y,1)
        {
            gravity_place = true
            move_place = true
        }

        if gravity_state = 0 || move_hit_ext || gravity_hit_up
        {
            bounce = true

            if gravity_hit_up
            {
                gravity_place = false
                move_place = false
            }
        }
    }

    if bounce
    {
        bounce = false
        count += 1
        move_hit_ext = false
        gravity_v = -8
        move_v = ( 10+irandom(32) )/8.0
        move_dir += 180

        var boom;
        boom = instance_create(x, y, o_boom)
        boom.image_xscale = image_xscale
        boom.image_yscale = image_yscale

        audio_sound_play("boom")
    }

    if count >= 3
        explode = true

    if gravity_water
    {
        explode = true
        move_v = 0
        gravity_v = gravity_max_water

        bubble += 1
        if bubble >= 25
        {
            bubble = 0
            var bub;
            bub = instance_create(x, y, o_bubble)
            bub.dir = gravity_dir + 180
        }
    }

    if water_in
        audio_sound_play("splash")

    if explode
    {
        gravity_place = false
        move_place = false
    }

    if bbox_get_right() < view_xview[0] - 16 || bbox_get_left() > view_xview[0] + view_wview[0] + 16
    || bbox_get_top() > view_yview[0] + view_hview[0] + 16
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
