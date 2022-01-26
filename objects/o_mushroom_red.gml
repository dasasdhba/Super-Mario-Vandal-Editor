#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_user(0)

sprite_fix_offset(16,31)

instance_init()
physics_init()

phy_type = 0
gravity_dir = image_angle+270
gravity_a = 0.4
gravity_d = 0.4
move_mode = 1

velocity = 2

scores = 1000
activate = false
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause && !bonus_place
{
    if !activate
    {
        if !out_of_frame(64)
        {
            activate = true
            if abs(sind(gravity_dir)) >= abs(cosd(gravity_dir))
            {
                if x*sign(sind(gravity_dir)) <= o_mario.x*sign(sind(gravity_dir))
                    move_dir = gravity_dir - 90
                else
                    move_dir = gravity_dir + 90
            }
            else
            {
                if y*sign(cosd(gravity_dir)) <= o_mario.y*sign(cosd(gravity_dir))
                    move_dir = gravity_dir - 90
                else
                    move_dir = gravity_dir + 90
            }

        }
    }
    else
    {
        //rise
        if bonus_rise
        {
            if physics_place(x,y,1)
            {
                x -= bonus_rise_v * cosd(gravity_dir)
                y += bonus_rise_v * sind(gravity_dir)
            }
            else
                bonus_rise = false

        }
        else
        {
            move_v = velocity
            physics_step()

            if place_meeting_round(x,y,o_mario) && o_mario.pipe = 0
            {
                var s;
                s = instance_create((bbox_left+bbox_right)/2, min(bbox_top,bbox_bottom), o_score)
                s.scores = scores

                if global.mario = 0
                {
                    audio_sound_play("powerup")
                    global.mario = 1
                    with(o_mario)
                    {
                        change = change_time

                        mask_index = s_mask_mario_big
                        if physics_place(x,y,1)
                        {
                            var powerup_fix;
                            powerup_fix = physics_fix(x,y,gravity_dir,1,32)
                            if powerup_fix
                            {
                                gravity_v = 0
                                gravity_hit_up = true
                            }
                            else
                                crouch_fix = true
                        }

                    }
                }
                else
                    audio_sound_play("reserve")

                instance_destroy()
            }

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
    draw_self()
