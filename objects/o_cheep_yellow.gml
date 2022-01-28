#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_user(0)
shell = 1
turn = false
def_stomp = -1
def_fireball = 0
def_beet = 0
def_bump = -1

sprite_fix_offset(16,36)
image_speed = 0.15

instance_init()
move_v = 0
move_dir = 0

velocity = 1.5
range = 800

dir = -1

scores = 1000
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
            activate = true
    }
    else
    {
        if instance_number(o_mario) > 0 && o_mario.x > x-range && o_mario.x < x+range && o_mario.y > y-range && o_mario.y < y+range
        {
            move_v = velocity
            move_dir = point_direction(x,y,o_mario.x,o_mario.y)

            if abs(cosd(image_angle)) >= abs(sind(image_angle))
            {
                if x*sign(cosd(image_angle)) <= o_mario.x*sign(cosd(image_angle))
                    dir = 1
                else
                    dir = -1
            }
            else
            {
                if y*sign(sind(image_angle)) <= o_mario.y*sign(sind(image_angle))
                    dir = 1
                else
                    dir = -1
            }
        }
        else
            move_v = 0

        x += move_v*cosd(move_dir)
        y -= move_v*sind(move_dir)

        //water_detect
        if place_meeting_round(x,y,o_water)
        {
            var gravity_dir;
            gravity_dir = image_angle + 270
            while ( !place_meeting_round(x-16*cosd(gravity_dir),y+16*sind(gravity_dir),o_water) )
            {
                x += cosd(gravity_dir)
                y -= sind(gravity_dir)
            }
        }

        //attacked
        event_user(1)

        if atk > 0
        {
            if atk < 5
            {
                var s;
                s = instance_create((bbox_left+bbox_right)/2, min(bbox_top,bbox_bottom), o_score)
                s.scores = scores
            }

            var death;
            death = instance_create(x, y, o_enemy_death)
            death.sprite_index = sprite_index
            death.image_angle = image_angle
            death.image_xscale = dir*image_xscale
            death.image_yscale = image_yscale
            death.yflip = true
            death.gravity_dir = image_angle + 270

            if atk != 5 && atk != 6
                audio_sound_play("kick_1")

            instance_destroy()
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
    draw_self_scale(dir*image_xscale,image_yscale)
