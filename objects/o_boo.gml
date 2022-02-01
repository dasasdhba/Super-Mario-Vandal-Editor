#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_fix_offset(16,31)
image_speed = 0

instance_init()
pause = -1

v = 0
velocity = 1
a = 0.5/8

alpha = 0.5
alpha_v = 0.05

dir = -1
activate = false
angle = 0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    if !activate
    {
        if !out_of_frame(32)
            activate = true
    }
    else
    {
        if instance_number(o_mario) > 0
        {
            angle = point_direction(x, y, o_mario.x, o_mario.y)

            if x < o_mario.x
            {
                dir = 1
                if o_mario.dir = -1
                {
                    v -= a
                    image_index = 0
                }
                else
                {
                    v += a
                    image_index = 1
                }
            }
            else
            {
                dir = -1
                if o_mario.dir = 1
                {
                    v -= a
                    image_index = 0
                }
                else
                {
                    v += a
                    image_index = 1
                }
            }
        }
        else
        {
            v -= a
            image_index = 0
        }

        if v < 0
            v = 0
        if v > velocity
            v = velocity

        x += v*cosd(angle)
        y -= v*sind(angle)

        if image_index = 0
        {
            if image_alpha > alpha
                image_alpha -= alpha_v
            else
                image_alpha = alpha
        }
        else
        {
            if image_alpha < 1
                image_alpha += alpha_v
            else
                image_alpha = 1
        }

        hurt_mario()
    }

}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !out_of_frame()
    draw_self_scale(dir*image_xscale,image_yscale)
