#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
physics_init()

phy_type = 2

gravity_place = false
move_place = false

gravity_state = 1
gravity_a = 0.4
gravity_d = 0.4
gravity_a_water = 0.4
gravity_d_water = 0.4
gravity_max_water = 10

count = 0
image_speed = 0

xflip = false
yflip = false
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    physics_step()

    //fall
    var f_height;
    f_height = sprite_height + 16
    if ( ( gravity_dir >= 225 && gravity_dir <= 315 ) && y >= view_yview[0] + view_hview[0] + f_height )
    || ( ( gravity_dir >= 45 && gravity_dir <= 135 ) && y <= view_yview[0] - f_height )
    || ( ( gravity_dir >= 135 && gravity_dir <= 225 ) && x <= view_xview[0] - f_height )
    || ( ( gravity_dir >= 315 || gravity_dir <= 45 ) && x >= view_xview[0] + view_wview[0] + f_height )
        instance_destroy()

    if gravity_state = 0 || gravity_place
    {
        count += 1
        if count >= 200
        {
            if global.effect
            {
                image_alpha -= 0.04
                if image_alpha <= 0
                    instance_destroy()
            }
            else
                instance_destroy()
        }
    }

    //flip
    if xflip
    {
        xflip = false
        image_xscale *= -1
        var delta;
        delta = sprite_get_width(sprite_index) - 2*sprite_get_xoffset(sprite_index)
        x += delta*abs(image_xscale)*cosd(image_angle)
        y -= delta*abs(image_xscale)*sind(image_angle)
    }
    if yflip
    {
        yflip = false
        image_yscale *= -1
        var delta;
        delta = sprite_get_height(sprite_index) - 2*sprite_get_yoffset(sprite_index)
        x += delta*abs(image_yscale)*sind(image_angle)
        y += delta*abs(image_yscale)*cosd(image_angle)
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
