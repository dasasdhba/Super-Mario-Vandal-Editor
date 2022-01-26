#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_user(0)
turn = false
invincible = true
def_stomp = -1
def_lava = -1

instance_init()
physics_init()
phy_type = 2
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
    gravity_place = false
    move_place = false
    gravity_hit_up = true
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

    event_user(1)
    if hurt_flag && !explode
        bounce = true

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

    //fall
    var f_height;
    f_height = sprite_height + 16
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
