#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_fix_offset(13,16)
image_speed = 0.5

instance_init()
physics_init()
gravity_place = false
gravity_state = 1
gravity_dir = image_angle+270
gravity_a = 0.2
gravity_d = 0.2
move_state = -1
move_place = false

angle = 180
angle_v = 15

interval = 100
interval_first = 50

xorigin = x
yorigin = y

count = 0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    physics_step()

    if gravity_v >= 0 && gravity_state = 1
    {
        if angle < 180
            angle += angle_v
        else
            angle = 180

        if place_meeting_round(x,y,o_lava)
        {
            visible = false
            gravity_state = -1
            var spray;
            spray = instance_create(x,y,o_spray_lava)
            spray.x = x + 16*image_yscale*sind(image_angle)
            spray.y = y + 16*image_yscale*cosd(image_angle)
            spray.image_xscale = image_xscale
            spray.image_yscale = image_yscale
            spray.image_angle = image_angle
        }
    }

    if gravity_state = -1
    {
        count += 1
        if count >= interval + interval_first
        {
            count = 0
            interval_first = 0
            visible = true
            gravity_state = 1
            gravity_v = 0-sqrt(2*gravity_a*point_distance(x, y, xorigin, yorigin))
            angle = 0
        }
    }
    else
    {
        hurt_mario()

        //ice_break
        globalvar _self;
        _self = id
        with(o_block_ice)
        {
            if place_meeting(x,y,_self)
                destroy = true
        }
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !out_of_frame()
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle+angle, image_blend, image_alpha)
