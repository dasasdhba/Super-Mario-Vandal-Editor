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
gravity_a_water = 0.104
gravity_d_water = 0.884
gravity_max_water = 5.25

move_v = 8.125
move_mode = 2

dir = 1
angle = 0
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

    physics_step()

    if gravity_state = 0
        gravity_v = -5

    //ice break
    if gravity_hit_up || gravity_hit_down
    {
        var ice, _dir;
        if gravity_hit_up
            _dir = -1
        else
            _dir = 1
        do
        {
            ice = instance_place_round(x+cosd(gravity_dir)*_dir,y+sind(gravity_dir)*_dir,o_block_ice)
            if ice
            {
                ice.destroy = true
                explode = true
                instance_deactivate_object(ice)
            }
        }
        until( !ice )
        instance_activate_object(o_block_ice)
    }

    if move_hit_ext
    {
        var ice;
        do
        {
            ice = instance_place_round(x+cosd(move_dir),y-sind(move_dir),o_block_ice)
            if ice
            {
                ice.destroy = true
                explode = true
                instance_deactivate_object(ice)
            }
        }
        until( !ice )
        instance_activate_object(o_block_ice)
    }

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

    if bbox_get_right() < view_xview[0] - 16 || bbox_get_left() > view_xview[0] + view_wview[0] + 16
    || bbox_get_top() > view_yview[0] + view_hview[0] + 16
        instance_destroy()

    if water_in
        audio_sound_play("splash")
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !out_of_frame(16)
    draw_sprite_ext(sprite_index, 0, x, y, dir*image_xscale, image_yscale, angle, image_blend, image_alpha)
