#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_fix_offset(16,16)
image_speed = 0.5

instance_init()

ID = ""
xcenter = 0
ycenter = 0
radius = 0
phase = 0
velocity = ""
flower = 0

wcenter = 0
hcenter = 0

f_count = 0

create_center = false
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    if is_real(ID)
    {
        var r;
        if flower = 0
            r = radius
        else if flower < 0
        {
            f_count += 1
            r = radius + flower*f_count
            if r <= 0
            {
                r = 0
                flower *= -1
                f_count = 0
            }
        }
        else
        {
            f_count += 1
            r = flower*f_count
            if r >= radius
            {
                r = radius
                flower *= -1
                f_count = 0
            }
        }

        x = xcenter + r*cosd(phase)
        y = ycenter - r*sind(phase)
        phase += velocity
        while (phase < 0)
            phase += 360
        phase = phase mod 360

        if !create_center
        {
            create_center = true
            var tile;
            tile = tile_add(tile_scenery_1,96,160,32,32,xcenter-16*wcenter,ycenter-16*hcenter,100000)
            tile_set_scale(tile, wcenter, hcenter)
            tile_set_blend(tile,image_blend)
            tile_set_alpha(tile,image_alpha)
        }
    }

    hurt_mario()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !out_of_frame()
    draw_self()
