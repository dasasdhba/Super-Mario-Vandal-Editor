#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_user(0)
def_fireball = -1
def_beet = -1
def_bump = -1
def_shell = -1
def_star = -1
def_lava = -1

sprite_fix_offset(17,14)
image_speed = 0.5

velocity = 3.25
a = 0.125
velocity_max = 4
dir = 0

scores = 100
activate = false
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
        if !out_of_frame(64)
        {
            activate = true
            if abs(cosd(image_angle)) >= abs(sind(image_angle))
            {
                if x <= o_mario.x
                    dir = 0
                else
                    dir = 180
            }
            else
            {
                if y <= o_mario.y
                    dir = 270
                else
                    dir = 90
            }
        }
    }
    else
    {
        x += velocity*cosd(dir)
        y -= velocity*sind(dir)

        //animation direction
        image_angle = dir
        if abs(cosd(dir)) >= abs(sind(dir))
        {
            if sign(cosd(dir))*image_yscale < 0
                image_yscale *= -1

            if instance_number(o_mario) > 0 && x*sign(cosd(dir)) > o_mario.x*sign(cosd(dir))
            {
                velocity -= a
                if velocity <= 0
                {
                    velocity = 0
                    dir += 180
                    dir = dir mod 360
                }
            }
            else
            {
                velocity += a
                if velocity > velocity_max
                    velocity = velocity_max
            }
        }
        else
        {
            if sign(sind(dir))*image_yscale > 0
                image_yscale *= -1

            if instance_number(o_mario) > 0 && y*sign(sind(dir)) < o_mario.y*sign(sind(dir))
            {
                velocity -= a
                if velocity <= 0
                {
                    velocity = 0
                    dir += 180
                    dir = dir mod 360
                }
            }
            else
            {
                velocity += a
                if velocity > velocity_max
                    velocity = velocity_max
            }
        }
        if image_xscale < 0
            image_xscale *= -1

        //attacked
        event_user(1)

        if atk = 1
        {
            var s;
            s = instance_create((bbox_left+bbox_right)/2, min(bbox_top,bbox_bottom), o_score)
            s.scores = scores

            var death;
            death = instance_create(x, y, o_enemy_death)
            death.sprite_index = sprite_index
            death.image_index = 5
            death.image_angle = image_angle
            death.image_xscale = image_xscale
            death.image_yscale = image_yscale
            death.gravity_dir = o_mario.gravity_dir
            death.gravity_v = velocity*sind(o_mario.gravity_dir - dir + 90)
            death.move_v = velocity*cosd(o_mario.gravity_dir - dir + 90)
            death.move_dir = dir + o_mario.gravity_dir - dir + 90
            death.gravity_a = 0.2
            death.gravity_d = 0.2

            instance_destroy()
        }

        //out_of_border
        if out_of_frame(512)
            instance_destroy()

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
