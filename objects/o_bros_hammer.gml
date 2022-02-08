#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_user(0)
turn = false

sprite_fix_offset(24,48)
image_speed = 0.1

instance_init()
physics_init()

phy_type = 2
gravity_dir = image_angle+270
gravity_a = 0.2
gravity_d = 0.2

velocity = 2
walk_time = 32
walk_time_random = 64
stop_time = 100
stop_v = 1
stop_v_random = 5
jump_interval = 10
jump_v_up = 8
jump_v_down = 3
jump_p_up = 0.05
jump_p_down = 0.05
launch_interval = 3
launch_p = 1/11.0
launch_time = 30

scores = 500
activate = false

dir = 1

state = 0
walk_count = 0
walk_random = 0
stop_count = 0
stop_random = 0
jump_state = 0
jump_count = 0
launch_state = 0
launch_count = 0
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
        //walk
        if state = 0
        {
            state = 1
            stop_random = irandom(stop_v_random)
            walk_random = irandom(walk_time_random)
            stop_count = 0
            walk_count = 0 - ( walk_time - walk_random )
        }

        if state = 1 && walk_count = 0 && stop_count >= stop_time
        {
            stop_count = 0
            walk_count = ( walk_time - walk_random )*2
            state = 2
        }

        if state = 2 && walk_count = 0 && stop_count >= stop_time
        {
            stop_count = 0
            walk_count = 0 - ( walk_time - walk_random )
            state = 3
        }

        if state = 3 && walk_count = 0
            state = 0

        //velocity
        if walk_count < 0
        {
            walk_count += 1
            move_v = velocity
            move_dir = gravity_dir - 90
        }
        else if walk_count > 0
        {
            walk_count -= 1
            move_v = velocity
            move_dir = gravity_dir + 90
        }
        else
        {
            move_v = 0
            stop_count += stop_v + stop_random
        }

        //jump
        if jump_state = -1 && gravity_state = 0
            jump_state = 0

        if jump_state = 0
        {
            jump_count += 1
            if jump_count >= jump_interval
            {
                jump_count = 0
                if place_meeting_round(x,y,o_bros_jump_down)
                {
                    var jump_random;
                    jump_random = random(1)
                    if jump_random < jump_p_down
                    {
                        gravity_v = 0 - jump_v_down
                        jump_state = 2
                    }
                    else if ( 1-jump_random ) < jump_p_up
                    {
                        gravity_v = 0 - jump_v_up
                        jump_state = 1
                    }

                }

                if place_meeting_round(x,y,o_bros_jump_up)
                {
                    var jump_random;
                    jump_random = random(1)
                    if jump_random < jump_p_up
                    {
                        gravity_v = 0 - jump_v_up
                        jump_state = 1
                    }

                }
            }
        }

        if jump_state = 1
        {
            if gravity_v < 0
            {
                gravity_place = false
                move_place = false
            }
            else if !physics_place(x,y,1)
            {
                gravity_place = true
                move_place = true
                jump_state = -1
            }

        }

        if jump_state = 2
        {
            gravity_place = false
            move_place = false
            if physics_place(x,y,1)
                jump_state = 3
        }

        if jump_state = 3 && !physics_place(x,y,1)
        {
            gravity_place = true
            move_place = true
            jump_state = -1
        }

        physics_step()

        //get direction
        if abs(sind(gravity_dir)) >= abs(cosd(gravity_dir))
        {
            if x*sign(sind(gravity_dir)) <= o_mario.x*sign(sind(gravity_dir))
                dir = -1
            else
                dir = 1
        }
        else
        {
            if y*sign(cosd(gravity_dir)) <= o_mario.y*sign(cosd(gravity_dir))
                dir = -1
            else
                dir = 1
        }

        //launch
        if launch_state = 0
        {
            image_play(0,1,image_speed)

            if !out_of_frame(32)
                launch_count += 1
            if launch_count >= launch_interval
            {
                launch_count = 0
                var launch_random;
                launch_random = random(1)
                if launch_random < launch_p
                    launch_state = 1
            }
        }

        if launch_state = 1
        {
            image_play(2,3,image_speed)
            launch_count += 1
            if launch_count >= launch_time
            {
                launch_count = 0
                launch_state = 0
                audio_sound_play("hammer")

                var weapon,wx,xy;
                wx = 7*dir*image_xscale
                wy = -32*image_yscale
                weapon = instance_create(x+wx*cosd(image_angle)+wy*sind(image_angle), y-wx*sind(image_angle)+wy*cosd(image_angle), o_hammer_bros)
                weapon.image_xscale = image_xscale
                weapon.image_yscale = image_yscale
                weapon.image_angle = image_angle
                weapon.gravity_dir = gravity_dir
                weapon.move_dir = gravity_dir + dir*90
                weapon.dir = dir
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
            death.gravity_dir = gravity_dir

            if ( atk > 1 && atk < 5 ) || ( atk = 7 && !out_of_frame(64) )
                audio_sound_play("kick_1")

            instance_destroy()
        }

        //fall
        var f_height;
        f_height = sprite_height + 16
        if ( ( gravity_dir >= 225 && gravity_dir <= 315 ) && y >= room_height + f_height )
        || ( ( gravity_dir >= 45 && gravity_dir <= 135 ) && y <= 0 - f_height )
        || ( ( gravity_dir >= 135 && gravity_dir <= 225 ) && x <= 0 - f_height )
        || ( ( gravity_dir >= 315 || gravity_dir <= 45 ) && x >= room_width + f_height )
            instance_destroy()

    }

}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !out_of_frame(64)
    draw_self_scale(dir*image_xscale,image_yscale)
