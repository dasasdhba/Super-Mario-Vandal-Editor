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
    }

    event_user(1)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if is_real(ID) && ( xcenter < view_xview[0]+view_xview[0] || xcenter+32*wcenter > view_xview[0] || ycenter < view_yview[0]+view_hview[0] || ycenter+32*hcenter > view_yview[0] )
    draw_sprite_ext(s_roto_center, 0, xcenter-16*wcenter, ycenter-16*hcenter, wcenter, hcenter, 0, image_blend, image_alpha)

if !out_of_frame()
    draw_self()
