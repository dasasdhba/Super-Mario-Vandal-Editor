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
gravity_a_water = 0.104
gravity_d_water = 0.884
gravity_max_water = 5.25

move_v = 8.125
move_mode = 2

dir = 1
angle = 0
if physics_place(x,y,1)
    explode = true
else
    explode = false
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    angle -= 20 * dir

    if !explode
        physics_step()

    event_user(1)
    if hurt_flag
        explode = true

    if gravity_state = 0
        gravity_v = -5

    if gravity_hit_up || move_hit_ext
        explode = true

    if explode
    {
        audio_sound_play("fireball_hit")
        var boom;
        boom = instance_create(x, y, o_boom)
        boom.image_xscale = image_xscale
        boom.image_yscale = image_yscale
        instance_destroy()
    }

    if water_in
        audio_sound_play("splash")

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
if !out_of_frame(16)
    draw_sprite_ext(sprite_index, 0, x, y, dir*image_xscale, image_yscale, angle, image_blend, image_alpha)
