#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
physics_init()

gravity_state = 1
gravity_place = false
move_place = false

gravity_a = 0.3
gravity_d = 0.3
gravity_a_water = 0.104
gravity_d_water = 0.884
gravity_max_water = 5.25

xspeed = 0
dir = 1

angle = 0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    if xspeed != 0
        dir = sign(xspeed)
    else
        dir = 1

    angle -= 20 * dir

    physics_step()
    x += xspeed

    hurt_mario()

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
