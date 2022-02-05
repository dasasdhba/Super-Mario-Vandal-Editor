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
        globalvar _self, _dir;
        _self = id
        if gravity_hit_up
            _dir = -1
        else
            _dir = 1
        with(o_block_ice)
        {
            if place_meeting(x-cosd(_self.gravity_dir)*_dir,y+sind(_self.gravity_dir)*_dir,_self)
            {
                destroy = true
                _self.explode = true
            }
        }
    }

    if move_hit_ext
    {
        globalvar _self, _dir;
        _self = id
        with(o_block_ice)
        {
            if place_meeting(x-cosd(_self.move_dir),y+sind(_self.move_dir),_self)
            {
                destroy = true
                _self.explode = true
            }
        }
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
