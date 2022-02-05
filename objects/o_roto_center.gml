#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
pause = -1

ID = ""
radius = 160
phase = 0
velocity = 1
if place_meeting(x,y,o_roto_flower)
    flower = true
else
    flower = false
f_velocity = 5
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if is_real(ID)
{
    globalvar _self;
    _self = id
    with(o_roto_disc)
    {
        if is_real(ID)
        {
            if ID = _self.ID
            {
                xcenter = _self.x + 16*image_xscale
                ycenter = _self.y + 16*image_yscale
                wcenter = _self.image_xscale
                hcenter = _self.image_yscale
                radius = point_distance(xcenter, ycenter, x, y)
                phase = point_direction(xcenter, ycenter, x, y)
                if !is_real(velocity)
                    velocity = _self.velocity
                if _self.flower
                    flower = 0 - _self.f_velocity
            }
        }

    }
}
else
{
    var disc;
    disc = instance_create(x,y,o_roto_disc)
    disc.ID = -1
    disc.xcenter = x + 16*image_xscale
    disc.ycenter = y + 16*image_yscale
    disc.wcenter = image_xscale
    disc.hcenter = image_yscale
    disc.radius = radius
    disc.phase = phase
    disc.velocity = velocity
    if flower
        disc.flower = 0 - f_velocity
}

instance_destroy()
