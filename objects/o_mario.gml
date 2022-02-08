#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//init
instance_init()
physics_init()

sprite_fix_offset(16,31)

phy_type = 1
gravity_dir = image_angle+270

//argument for Mario

//walk
dir = 1
velocity = 0
first_v = 8
a = 1 // acceleration
d = 1 // deceleration
d_turn_walk = 4
d_turn_run = 4
d_crouch = 2
max_v_walk = 35
max_v_water = 35
max_v_walk_water = 35
max_v_run = 60

//jump
jump_v = 14
swim_v = 3.2
jump_out_water = 10
jump_out_water_floor = 12
jump_add_stop = 0.4
jump_add_move = 0.5
jump_add_lui = 0.6

//stomp
stomp = false
stomp_v = 9
stomp_v_press = 13

//health
fall = true // Mario will fall to death
hurt_time = 100
hurt = 0
death = false
invincible = false
star_time = 500
star = 0
star_count = 0

//control
control = true
left = false
right = false
left_latest = 0
right_latest = 0
delay = 0
jump = false

//animation
swim = false
change = 0
change_time = 40
launch = 0
bubble = 0
lui = 0

//others
pipe = 0 // = 0: normal, = 1~4: enter pipe, = 5: warp, =6: exit check, = 7~10: exit pipe
pipe_count = 0
crouch = false
crouch_fix = false
crouch_fix_v = 2
pass = false

//start pipe exit
if global.checkpoint = 0 && place_meeting(x,y,o_pipe_exit)
{
    pipe = 6
    gravity_state = -1
    move_state = -1
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
// the movement of mario

if !global.pause
{
    //switch the mask
    if global.mario = 0 || ( global.mario > 0 && crouch )
        mask_index = s_mask_mario_small
    if global.mario > 0 && !crouch
        mask_index = s_mask_mario_big

    //move
    if control && move_state != -1
    {
        //get control
        if delay > 0
        {
            if ( keyboard_check(global.key_up) && !keyboard_check(global.key_down) && !keyboard_check(global.key_left) && !keyboard_check(global.key_right) )
            || ( !keyboard_check(global.key_up) && keyboard_check(global.key_down) && !keyboard_check(global.key_left) && !keyboard_check(global.key_right) )
            || ( !keyboard_check(global.key_up) && !keyboard_check(global.key_down) && keyboard_check(global.key_left) && !keyboard_check(global.key_right) )
            || ( !keyboard_check(global.key_up) && !keyboard_check(global.key_down) && !keyboard_check(global.key_left) && keyboard_check(global.key_right) )
                delay = 1

            if ( left_latest = 1 && ( !keyboard_check(global.key_left) || keyboard_check(global.key_right) ) )
            || ( left_latest = 2 && ( keyboard_check(global.key_left) || !keyboard_check(global.key_right) ) )
            || ( left_latest = 3 && ( !keyboard_check(global.key_up) || keyboard_check(global.key_down) ) )
            || ( left_latest = 4 && ( keyboard_check(global.key_up) || !keyboard_check(global.key_down) ) )
            {
                left_latest = 0
                left = false
                delay = 0
            }

            if ( right_latest = 1 && ( !keyboard_check(global.key_left) || keyboard_check(global.key_right) ) )
            || ( right_latest = 2 && ( keyboard_check(global.key_left) || !keyboard_check(global.key_right) ) )
            || ( right_latest = 3 && ( !keyboard_check(global.key_up) || keyboard_check(global.key_down) ) )
            || ( right_latest = 4 && ( keyboard_check(global.key_up) || !keyboard_check(global.key_down) ) )
            {
                right_latest = 0
                right = false
                delay = 0
            }
        }

        if delay = 0
        {
            if ( !keyboard_check(global.key_left) && keyboard_check(global.key_right) )
            || ( keyboard_check(global.key_left) && !keyboard_check(global.key_right) )
            || ( !keyboard_check(global.key_up) && keyboard_check(global.key_down) )
            || ( keyboard_check(global.key_up) && !keyboard_check(global.key_down) )
            {
                left = false
                right = false
                left_latest = 0
                right_latest = 0

                if gravity_dir >= 225 && gravity_dir <= 315
                {
                    if keyboard_check(global.key_left)
                    {
                        left = true
                        left_latest = 1
                        delay = 1
                    }
                    if keyboard_check(global.key_right)
                    {
                        right = true
                        right_latest = 2
                        delay = 1
                    }
                }
                if gravity_dir >= 45 && gravity_dir <= 135
                {
                    if keyboard_check(global.key_right)
                    {
                        left = true
                        left_latest = 2
                        delay = 1
                    }
                    if keyboard_check(global.key_left)
                    {
                        right = true
                        right_latest = 1
                        delay = 1
                    }
                }
                if gravity_dir >= 45 && gravity_dir <= 135
                {
                    if keyboard_check(global.key_up)
                    {
                        left = true
                        left_latest = 3
                        delay = 1
                    }
                    if keyboard_check(global.key_down)
                    {
                        right = true
                        right_latest = 4
                        delay = 1
                    }
                }
                if gravity_dir >= 315 || gravity_dir <= 45
                {
                    if keyboard_check(global.key_down)
                    {
                        left = true
                        left_latest = 4
                        delay = 1
                    }
                    if keyboard_check(global.key_up)
                    {
                        right = true
                        right_latest = 3
                        delay = 1
                    }
                }
            }
        }

        if delay = 1
        {
            if left
            {
                if left_latest = 1 || left_latest = 2
                {
                    if ( gravity_dir >= 315 || gravity_dir <= 45 ) && keyboard_check(global.key_up) && !keyboard_check(global.key_down)
                    {
                        left_latest = 0
                        right_latest = 3
                        left = false
                        right = true
                        delay = 2
                    }
                    if ( gravity_dir >= 135 && gravity_dir <= 225 ) && !keyboard_check(global.key_up) && keyboard_check(global.key_down)
                    {
                        left_latest = 0
                        right_latest = 4
                        left = false
                        right = true
                        delay = 2
                    }
                }
                if left_latest = 3 || left_latest = 4
                {
                    if ( gravity_dir >= 45 || gravity_dir <= 135 ) && keyboard_check(global.key_left) && !keyboard_check(global.key_right)
                    {
                        left_latest = 0
                        right_latest = 1
                        left = false
                        right = true
                        delay = 2
                    }
                    if ( gravity_dir >= 225 || gravity_dir <= 315 ) && !keyboard_check(global.key_left) && keyboard_check(global.key_right)
                    {
                        left_latest = 0
                        right_latest = 2
                        left = false
                        right = true
                        delay = 2
                    }
                }
            }
            if right
            {
                if right_latest = 1 || right_latest = 2
                {
                    if ( gravity_dir >= 135 && gravity_dir <= 225 ) && keyboard_check(global.key_up) && !keyboard_check(global.key_down)
                    {
                        left_latest = 3
                        right_latest = 0
                        left = true
                        right = false
                        delay = 2
                    }
                    if ( gravity_dir >= 315 || gravity_dir <= 45 ) && !keyboard_check(global.key_up) && keyboard_check(global.key_down)
                    {
                        left_latest = 4
                        right_latest = 0
                        left = true
                        right = false
                        delay = 2
                    }
                }
                if left_latest = 3 || left_latest = 4
                {
                    if ( gravity_dir >= 225 || gravity_dir <= 315 ) && keyboard_check(global.key_left) && !keyboard_check(global.key_right)
                    {
                        left_latest = 1
                        right_latest = 0
                        left = true
                        right = false
                        delay = 2
                    }
                    if ( gravity_dir >= 45 || gravity_dir <= 135 ) && !keyboard_check(global.key_left) && keyboard_check(global.key_right)
                    {
                        left_latest = 2
                        right_latest = 0
                        left = true
                        right = false
                        delay = 2
                    }
                }
            }
        }

        //walk and run
        if !crouch && ( ( dir = 1 && right && !left ) || ( dir = -1 && left && !right ) )
        {
            if velocity < first_v
                velocity += first_v
            if !gravity_water
            {
                if !keyboard_check(global.key_fire)
                {
                    if velocity < max_v_walk
                        velocity += a
                    if velocity > max_v_walk
                        velocity -= d
                }
                else
                {
                    if velocity < max_v_run
                        velocity += a
                    if velocity > max_v_run
                        velocity -= d
                }
            }
            else
            {
                if gravity_state = 0
                {
                    if velocity < max_v_walk_water
                        velocity += a
                    if velocity > max_v_walk_water
                        velocity -= d
                }
                else
                {
                    if velocity < max_v_water
                        velocity += a
                    if velocity > max_v_water
                        velocity -= d
                }
            }
        }

        //turn
        if ( dir = 1 && !right && left ) || ( dir = -1 && !left && right )
        {
            if velocity > max_v_walk
                velocity -= d_turn_run
            else if velocity > 0
                velocity -= d_turn_walk
            else
            {
                velocity = 0
                dir *= -1
            }
        }
    }

    //deceleration when losing control
    if velocity > 0
    {
        if !crouch && ( !control || !( left ^^ right ) )
            velocity -= d
        else if crouch
        {
            if !control || !( left ^^ right )
                velocity -= d_crouch
            else if control && !( dir = 1 && !right && left ) && !( dir = -1 && !left && right )
                velocity -= d
        }
    }
    if velocity < 0
        velocity = 0

    //jump
    if control && gravity_state != -1
    {
        if !gravity_water
            swim = false

        if jump && !keyboard_check(global.key_jump)
            jump = false

        if !jump && !crouch && keyboard_check(global.key_jump)
        {
            if !gravity_water && gravity_state = 0
            {
                jump = true
                gravity_v = 0-jump_v
                audio_sound_play("mario_jump")
            }
            if gravity_water
            {
                var place_water;
                place_water = instance_place_round(x,y,o_water)
                if place_water.swim
                {
                    jump = true
                    swim = true
                    image_index = 4

                    var water_out,place_obj;
                    water_out = true
                    place_obj = instance_place_round(x-24*cosd(gravity_dir),y+24*sind(gravity_dir),o_water)
                    if place_obj && ( place_obj.type = 0 || place_obj.type = phy_type )
                        water_out = false

                    if !water_out
                    {
                        gravity_v = 0-swim_v
                        audio_sound_play("mario_swim")
                    }
                    else
                    {
                        if gravity_state = 1
                        {
                            gravity_v = 0-jump_out_water
                            audio_sound_play("mario_swim")
                        }
                        else if gravity_state = 0
                        {
                            gravity_v = 0-jump_out_water_floor
                            audio_sound_play("mario_jump")
                        }
                    }
                }
            }
        }
    }
    else
        jump = false

    //stomp
    if stomp
    {
        stomp = false
        if control && keyboard_check(global.key_jump)
        {
            gravity_v = 0-stomp_v_press
            audio_sound_play("mario_stomp")
        }
        else
        {
            gravity_v = 0-stomp_v
            audio_sound_play("mario_stomp")
        }
    }

    //jumping height
    if gravity_v < 0 && !gravity_water
    {
        if control && keyboard_check(global.key_jump)
        {
            if global.mario != 4
                if velocity < 5
                    gravity_v -= jump_add_stop
                else
                    gravity_v -= jump_add_move
            else
                gravity_v -= jump_add_lui
        }
    }

    //crouch
    if !crouch && global.mario > 0 && gravity_state = 0 && control
        if ( ( gravity_dir >= 225 && gravity_dir < 315 ) && keyboard_check(global.key_down) )
        || ( ( gravity_dir >= 315 || gravity_dir < 45 ) && keyboard_check(global.key_right) )
        || ( ( gravity_dir >= 45 && gravity_dir < 135 ) && keyboard_check(global.key_up) )
        || ( ( gravity_dir >= 135 && gravity_dir < 225 ) && keyboard_check(global.key_left) )
            crouch = true

    if crouch
    {
        if global.mario = 0
        {
            crouch = false
            mask_index = s_mask_mario_small
        }

        else if gravity_state = 1
        {
            crouch = false
            mask_index = s_mask_mario_big
            if physics_place(x,y,1)
            {
                physics_fix(x,y,gravity_dir,1)
                gravity_v = 0
                gravity_hit_up = true
            }
        }

        else if control
            if ( ( gravity_dir >= 225 && gravity_dir < 315 ) && !keyboard_check(global.key_down) )
            || ( ( gravity_dir >= 315 || gravity_dir < 45 ) && !keyboard_check(global.key_right) )
            || ( ( gravity_dir >= 45 && gravity_dir < 135 ) && !keyboard_check(global.key_up) )
            || ( ( gravity_dir >= 135 && gravity_dir < 225 ) && !keyboard_check(global.key_left) )
            {
                crouch = false
                mask_index = s_mask_mario_big
                if physics_place(x,y,1)
                    crouch_fix = true
            }

        else if !control
        {
            crouch = false
            mask_index = s_mask_mario_big
            if physics_place(x,y,1)
                crouch_fix = true
        }
    }

    if crouch_fix
    {
        control = false
        move_state = -1
        move_v = 0
        gravity_state = -1
        gravity_v = 0

        if physics_place(x,y,1)
        {
            x -= crouch_fix_v*cosd(move_dir)
            y += crouch_fix_v*sind(move_dir)
        }
        else
        {
            move_state = 0
            gravity_state = 0
            crouch_fix = false
            if !pass
                control = true
        }

    }

    //physics
    if velocity > 0
        move_v = max(1, 0.1228*velocity - 0.1073)
    else
        move_v = 0
    move_dir = gravity_dir + 90*dir

    physics_step()

    if move_hit
        velocity = 0

    //water effect
    if gravity_water
        bubble += 1
    if bubble >= 5
    {
        bubble = 0
        if irandom(10) = 1
        {
            var bub, pos;
            pos = 18
            if global.mario > 0
                pos = 39
            bub = instance_create(x,y-pos,o_bubble)
            bub.dir = gravity_dir+180
        }
    }

    if water_in && pipe = 0 && gravity_v > 0
    {
        audio_sound_play("splash_big")
        var spray;
        spray = instance_create(x,y,o_spray_water)
        spray.image_angle = gravity_dir + 90
    }

    if water_out && pipe = 0 && gravity_v < 0
    {
        audio_sound_play("splash")
        var spray;
        spray = instance_create(x,y,o_spray_water)
        spray.image_angle = gravity_dir + 90
    }

}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//mario launch
if !global.pause && !crouch && pipe = 0 && control && keyboard_check_pressed(global.key_fire)
{
    if global.mario = 2 && instance_number(o_fireball_mario) < 2
    {
        var weapon;
        weapon = instance_create(x-28*image_yscale*sind(image_angle), y-28*image_yscale*cosd(image_angle), o_fireball_mario)
        weapon.image_xscale = image_xscale
        weapon.image_yscale = image_yscale
        weapon.angle = image_angle
        weapon.dir = dir
        weapon.move_dir = move_dir
        weapon.gravity_dir = gravity_dir

        audio_sound_play("fireball")
        launch = 4
    }

    if global.mario = 3 && instance_number(o_beet_mario) < 2
    {
        var weapon;
        weapon = instance_create(x-16*image_yscale*sind(image_angle), y-16*image_yscale*cosd(image_angle), o_beet_mario)
        weapon.image_xscale = image_xscale
        weapon.image_yscale = image_yscale
        weapon.image_angle = image_angle
        weapon.move_dir = move_dir
        weapon.gravity_dir = gravity_dir

        audio_sound_play("fireball")
        launch = 4
    }

}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//pipe
if !global.pause
{
    //pipe enter
    if pipe = 0
    {
        var enter;
        enter = instance_place_round(x,y,o_pipe_enter)
        if enter
        {
            var m_dir,p_dir;
            m_dir = ( round(gravity_dir / 90) * 90 ) mod 360
            p_dir = enter.image_angle
            while ( p_dir < 0 )
                p_dir += 360
            p_dir = p_dir mod 360

            //right
            if p_dir = ( m_dir + 90 ) mod 360 && right && !left && ( gravity_state = 0 || gravity_water )
            {
                pipe = 1
                image_angle = p_dir mod 360
                dir = 1
                if p_dir = 0
                {
                    x = enter.R - ( bbox_right - x )
                    y = enter.B
                }
                else if p_dir = 90
                {
                    x = enter.R
                    y = enter.T - ( bbox_top - y )
                }
                else if p_dir = 180
                {
                    x = enter.L - ( bbox_left - x )
                    y = enter.T
                }
                else if p_dir = 270
                {
                    x = enter.L
                    y = enter.B - ( bbox_bottom - y)
                }

                pipe_count = 0
                gravity_state = -1
                gravity_v = 0
                move_state = -1
                move_v = 0
                velocity = 0
                audio_sound_play("powerdown")
            }

            //up
            var up;
            if ( ( gravity_dir >= 225 && gravity_dir < 315 ) && keyboard_check(global.key_up) )
            || ( ( gravity_dir >= 315 || gravity_dir < 45 ) && keyboard_check(global.key_left) )
            || ( ( gravity_dir >= 45 && gravity_dir < 135 ) && keyboard_check(global.key_down) )
            || ( ( gravity_dir >= 135 && gravity_dir < 225 ) && keyboard_check(global.key_right) )
                up = true
            else
                up = false

            if p_dir = ( m_dir + 180 ) mod 360 && up && gravity_state = 1 && gravity_v <= 0
            {
                pipe = 2
                image_angle = ( p_dir + 270 ) mod 360
                if p_dir = 0
                {
                    x = enter.R - ( bbox_right - x )
                    y = (enter.T + enter.B)/2
                }
                else if p_dir = 90
                {
                    x = (enter.L + enter.R)/2
                    y = enter.T - ( bbox_top - y )
                }
                else if p_dir = 180
                {
                    x = enter.L - ( bbox_left - x )
                    y = (enter.T + enter.B)/2
                }
                else if p_dir = 270
                {
                    x = (enter.L + enter.R)/2
                    y = enter.B - ( bbox_bottom - y )
                }

                pipe_count = 0
                gravity_state = -1
                gravity_v = 0
                move_state = -1
                move_v = 0
                velocity = 0
                audio_sound_play("powerdown")
            }

            //left
            if p_dir = ( m_dir + 270 ) mod 360 && left && !right && ( gravity_state = 0 || gravity_water )
            {
                pipe = 3
                image_angle = ( p_dir + 180 ) mod 360
                dir = -1
                if p_dir = 0
                {
                    x = enter.R - ( bbox_right - x )
                    y = enter.T
                }
                else if p_dir = 90
                {
                    x = enter.L
                    y = enter.T - ( bbox_top - y )
                }
                else if p_dir = 180
                {
                    x = enter.L - ( bbox_left - x )
                    y = enter.B
                }
                else if p_dir = 270
                {
                    x = enter.R
                    y = enter.B - ( bbox_bottom - y )
                }

                pipe_count = 0
                gravity_state = -1
                gravity_v = 0
                move_state = -1
                move_v = 0
                velocity = 0
                audio_sound_play("powerdown")
            }

            //down
            var down;
            if ( ( gravity_dir >= 225 && gravity_dir < 315 ) && keyboard_check(global.key_down) )
            || ( ( gravity_dir >= 315 || gravity_dir < 45 ) && keyboard_check(global.key_right) )
            || ( ( gravity_dir >= 45 && gravity_dir < 135 ) && keyboard_check(global.key_up) )
            || ( ( gravity_dir >= 135 && gravity_dir < 225 ) && keyboard_check(global.key_left) )
                down = true
            else
                down = false

            if p_dir = m_dir mod 360 && down && gravity_state = 0
            {
                pipe = 4
                image_angle = ( p_dir + 90 ) mod 360
                if p_dir = 0
                {
                    x = enter.R
                    y = (enter.T + enter.B)/2
                }
                else if p_dir = 90
                {
                    x = (enter.L + enter.R)/2
                    y = enter.T
                }
                else if p_dir = 180
                {
                    x = enter.L
                    y = (enter.T + enter.B)/2
                }
                else if p_dir = 270
                {
                    x = (enter.L + enter.R)/2
                    y = enter.B+1
                }

                pipe_count = 0
                gravity_state = -1
                gravity_v = 0
                move_state = -1
                move_v = 0
                velocity = 0
                crouch = false
                audio_sound_play("powerdown")
            }

        }

    }

    if pipe > 0 && pipe < 5
    {
        pipe_count += 1

        if pipe = 1 && pipe_count <= 32
        {
            x += cosd(image_angle)
            y -= sind(image_angle)
        }
        if pipe = 2
        {
            x += cosd(image_angle + 90)
            y -= sind(image_angle + 90)
        }
        if pipe = 3 && pipe_count <= 32
        {
            x -= cosd(image_angle)
            y += sind(image_angle)
        }
        if pipe = 4
        {
            x -= cosd(image_angle + 90)
            y += sind(image_angle + 90)
        }

        if pipe_count >= 64
            pipe = 5

    }

    //pipe exit
    if pipe = 6
    {
        var out;
        out = instance_place_round(x,y,o_pipe_exit)
        if out
        {
            var o_dir,m_dir;
            o_dir = out.image_angle
            while ( o_dir < 0 )
                o_dir += 360
            o_dir = o_dir mod 360

            m_dir = image_angle + 270
            while ( m_dir < 0 )
                m_dir += 360
            m_dir = m_dir mod 360
        }

        //right
        if o_dir = ( m_dir + 90 ) mod 360
        {
            pipe = 7
            dir = 1

            var o_fix;
            if global.mario = 0
                o_fix = 6
            else
                o_fix = 11

            if o_dir = 0
            {
                x = out.R - ( bbox_right - x ) - o_fix
                y = out.B
            }
            else if o_dir = 90
            {
                x = out.R
                y = out.T - ( bbox_top - y ) + o_fix
            }
            else if o_dir = 180
            {
                x = out.L - ( bbox_left - x ) + o_fix
                y = out.T
            }
            else if o_dir = 270
            {
                x = out.L
                y = out.B - ( bbox_bottom - y ) - o_fix
            }

            pipe_count = 0
            audio_sound_play("powerdown")
        }

        //up
        if o_dir = ( m_dir + 180 ) mod 360
        {
            pipe = 8

            if o_dir = 0
            {
                x = out.R - 43
                y = (out.T + out.B) / 2
            }
            else if o_dir = 90
            {
                x = (out.L + out.R) / 2
                y = out.T + 43
            }
            else if o_dir = 180
            {
                x = out.L + 43
                y = (out.T + out.B) / 2
            }
            else if o_dir = 270
            {
                x = (out.L + out.R) / 2
                y = out.B - 43
            }

            pipe_count = 0
            audio_sound_play("powerdown")
        }

        //left
        if o_dir = ( m_dir + 270 ) mod 360
        {
            pipe = 9
            dir = -1

            var o_fix;
            if global.mario = 0
                o_fix = 6
            else
                o_fix = 11

            if o_dir = 0
            {
                x = out.R - ( bbox_right - x ) - o_fix
                y = out.T
            }
            else if o_dir = 90
            {
                x = out.L
                y = out.T - ( bbox_top - y ) + o_fix
            }
            else if o_dir = 180
            {
                x = out.L - ( bbox_left - x ) + o_fix
                y = out.B
            }
            else if o_dir = 270
            {
                x = out.R
                y = out.B - ( bbox_bottom - y ) - o_fix
            }

            pipe_count = 0
            audio_sound_play("powerdown")
        }

        //down
        if o_dir = m_dir mod 360
        {
            pipe = 10

            if o_dir = 0
            {
                x = out.R
                y = (out.T + out.B) / 2
            }
            else if o_dir = 90
            {
                x = (out.L + out.R) / 2
                y = out.T
            }
            else if o_dir = 180
            {
                x = out.L
                y = (out.T + out.B) / 2
            }
            else if o_dir = 270
            {
                x = (out.L + out.R) / 2
                y = out.B
            }

            pipe_count = 0
            audio_sound_play("powerdown")
        }

    }

    if pipe > 6 && pipe < 11
    {
        pipe_count += 1

        if pipe = 7
        {
            x += cosd(image_angle)
            y -= sind(image_angle)
        }
        if pipe = 8
        {
            x += cosd(image_angle + 90)
            y -= sind(image_angle + 90)
        }
        if pipe = 9
        {
            x -= cosd(image_angle)
            y += sind(image_angle)
        }
        if pipe = 10
        {
            x -= cosd(image_angle + 90)
            y += sind(image_angle + 90)
        }

        if ( pipe_count >= 32 && ( pipe = 7 || pipe = 9 ) )
        || ( pipe_count >= 45 && pipe = 8 )
        || ( pipe = 10 && ( ( global.mario = 0 && pipe_count >= 31 ) || pipe_count >= 58 ) )
        {
            if pipe = 10
                gravity_state = 1
            else
                gravity_state = 0

            if pipe = 8 && global.mario > 0
            {
                crouch = true
                mask_index = s_mask_mario_small
            }

            pipe = 0
            move_state = 0
        }

    }

}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    //fall
    if pipe = 0 && !pass && fall && !global.debug_inv
        if ( ( gravity_dir >= 225 && gravity_dir <= 315 ) && y >= view_yview[0] + view_hview[0] + 64*abs(image_yscale) )
        || ( ( gravity_dir >= 45 && gravity_dir <= 135 ) && y <= view_yview[0] - 64*abs(image_yscale) )
        || ( ( gravity_dir >= 135 && gravity_dir <= 225 ) && x <= view_xview[0] - 64*abs(image_yscale) )
        || ( ( gravity_dir >= 315 || gravity_dir <= 45 ) && x >= view_xview[0] + view_wview[0] + 64*abs(image_yscale) )
            death = true

    //crush
    if solid_crush && !global.debug_inv
        death = true

    //hurt
    if hurt = hurt_time
    {
        invincible = true
        if global.mario > 0
        {
            if global.mario > 1
                global.mario = 1
            else
                global.mario = 0

            change = change_time
            audio_sound_play("powerdown")
        }
        else
            death = true
    }

    if hurt > 0
    {
        if pipe = 0
            hurt -= 1
        image_alpha = min(1,(hurt mod 2) + 0.5)

        if hurt = 0
        {
            image_alpha = 1
            if !pass && pipe = 0
                invincible = false
        }
    }

    //star
    if star = star_time
    {
        invincible = true
        hurt = 0
        image_alpha = 1

        var i;
        for (i=0;i<=global.channel_max-1;i+=1)
        {
            var ins;
            ins = global.musicplay[i]
            if FMODInstanceIsPlaying(ins)
                FMODInstanceSetPaused(ins, 1)
        }

        var music;
        music = "starman"
        global.musicname[global.channel_max] = music
        global.musicplay[global.channel_max] = audio_music_play(music,-1)
        FMODInstanceSetVolume(global.musicplay[global.channel_max], global.music)
    }

    if star > 0
    {
        if pipe = 0
            star -= 1

        var effect;
        effect = instance_create(x-13+irandom(28),y-4,o_star_effect)
        if global.mario = 0
            effect.y -= irandom(25)
        else
            effect.y -= irandom(56)
        effect.image_index = irandom(5)
        effect.image_alpha = 0.6
        effect.alpha_v = random_range(0.05,0.08)
        effect.scale_v = random(0.1)

        if star = 150
            audio_sound_play("starman_end")

        if star < 100
            FMODInstanceSetVolume(global.musicplay[global.channel_max], global.music*star/100.0)

        if star = 0
        {
            star_count = 0
            if !pass && pipe = 0
                invincible = false

            FMODInstanceStop(global.musicplay[global.channel_max])

            var i;
            for (i=0;i<=global.channel_max-1;i+=1)
            {
                var ins;
                ins = global.musicplay[i]
                if FMODInstanceIsPlaying(ins)
                    FMODInstanceSetPaused(ins, 0)
            }

        }
    }

    if star_count < 0
    {
        star_count *= -1
        audio_sound_play("kick_"+string(star_count))

        if star_count < 7
        {
            var s;
            s = instance_create((bbox_left+bbox_right)/2, bbox_top, o_score)
            switch(star_count)
            {
                case 1: s.scores = 100; break;
                case 2: s.scores = 200; break;
                case 3: s.scores = 500; break;
                case 4: s.scores = 1000; break;
                case 5: s.scores = 2000; break;
                case 6: s.scores = 5000; break;
                default: break;
            }
        }
        else
        {
            instance_create((bbox_left+bbox_right)/2,bbox_top,o_life)
            star_count = 0
        }
    }

    //death
    if death
    {
        var d;
        d = instance_create(x,y,o_mario_death)
        d.gravtiy_dir = gravity_dir
        d.angle = angle
        instance_destroy()
    }

}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//mario animation
switch (global.mario)
{
    case 0: sprite_index = s_mario_small; break;
    case 1: sprite_index = s_mario_big; break;
    case 2: sprite_index = s_mario_fire; break;
    case 3: sprite_index = s_mario_beet; break;
    case 4: sprite_index = s_mario_lui; break;
    default: break;
}

if !global.pause && pipe = 0
{
    if !crouch && !crouch_fix && change = 0
    {
        if gravity_state = 0
        {
            if launch > 0
            {
                if global.mario > 1 && global.mario != 4 && !crouch && !crouch_fix && !change
                {
                    launch -= 1
                    image_index = 13
                }
                else
                    launch = 0
            }

            if launch = 0
            {
                if move_v <= 0
                    image_index = 0
                else
                    image_play(0,2,move_v/20.0)
            }

        }

        if gravity_state = 1
        {
            launch = 0
            if !gravity_water
                image_index = 3
            else
            {
                if swim
                {
                    var swim_finish;
                    swim_finish = image_play(4,7,0.15)
                    if swim_finish
                        swim = false
                }
                else
                    image_play(7,8,0.1)
            }
        }
    }

    if crouch && !crouch_fix && change = 0
    {
        launch = 0
        image_index = 12
    }

    if crouch_fix && change = 0
    {
        launch = 0
        image_index = 0
    }

    if change > 0
    {
        change -= 1
        launch = 0
        image_play(9,11,0.5)
    }

    //lui effect
    if global.effect && global.mario = 4 && gravity_state = 1
    {
        lui += 1
        if lui >= 3
        {
            lui = instance_create(x, y, o_shadow)
            lui.v = 0.04
            lui.sprite_index = s_mario_lui
            lui.image_index = image_index
            lui.image_xscale = dir*image_xscale
            lui.image_yscale = image_yscale
            lui.image_angle = image_angle

            lui = 0
        }
    }

}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !out_of_frame(16)
{
    if pipe = 0
        draw_self_scale(dir*image_xscale,image_yscale)
    else if pipe = 1 || pipe = 3
    {
        var pipe_walk,pipe_fix;
        pipe_walk = round(pipe_count*0.2) mod 3
        if global.mario = 0
            pipe_fix = 26
        else
            pipe_fix = 29

        draw_sprite_part_rot_ext(sprite_index,pipe_walk,x,y,0,0,pipe_fix-pipe_count,sprite_height,image_angle,dir*image_xscale,image_yscale,image_alpha)
    }
    else if pipe = 2
    {
        var pipe_fix;
        if global.mario = 0
            pipe_fix = 29
        else if global.mario = 1 || global.mario = 4
            pipe_fix = 5
        else if global.mario = 2
            pipe_fix = 5.5
        else if global.mario = 3
            pipe_fix = 8.5
        if pipe_fix+pipe_count < sprite_height
            draw_sprite_part_rot_ext(sprite_index,3,x,y,0,pipe_fix+pipe_count,sprite_width,sprite_height-(pipe_fix+pipe_count),image_angle,dir*image_xscale,image_yscale,image_alpha)
    }
    else if pipe = 4
        draw_sprite_part_rot_ext(sprite_index,12,x,y,0,0,sprite_width,sprite_height-pipe_count,image_angle,dir*image_xscale,image_yscale,image_alpha)
    else if ( pipe = 7 || pipe = 9 )
    {
        var pipe_walk,pipe_fix;
        pipe_walk = round(pipe_count*0.2) mod 3
        if global.mario = 0
            pipe_fix = 25
        else
            pipe_fix = 28

        draw_sprite_part_rot_ext(sprite_index,pipe_walk,x,y,sprite_width-pipe_count,0,pipe_count,sprite_height,image_angle,dir*image_xscale,image_yscale,image_alpha)
    }
    else if pipe = 8
    {
        var pipe_fix,pipe_h;
        if global.mario = 0
        {
            pipe_fix = 16
            pipe_h = 28
        }
        else
        {
            pipe_fix = 2
            pipe_h = 16
        }
        if pipe_count > pipe_fix
            draw_sprite_part_rot_ext(sprite_index,12,x,y,0,0,sprite_width,pipe_h+pipe_count-pipe_fix,image_angle,dir*image_xscale,image_yscale,image_alpha)
    }
    else if pipe = 10
        draw_sprite_part_rot_ext(sprite_index,3,x,y,0,sprite_height-pipe_count,sprite_width,pipe_count,image_angle,dir*image_xscale,image_yscale,image_alpha)

}

/*

//draw the animation

var mario_sprite;
switch (global.mario)
{
    case 0: mario_sprite = s_mario_small; break;
    case 1: mario_sprite = s_mario_big; break;
    case 2: mario_sprite = s_mario_fire; break;
    case 3: mario_sprite = s_mario_beet; break;
    case 4: mario_sprite = s_mario_lui; break;
    default: break;
}

if !crouch && !crouch_fix && change = 0
{
    if gravity_state = 0
    {
        if launch > 0
        {
            if global.mario > 1 && global.mario != 4 && !crouch && !crouch_fix && !change
            {
                if !global.pause
                    launch -= 1

                draw_sprite_ext(mario_sprite,13,x,y,dir,1,angle,c_white,alpha)
            }
            else
                launch = 0
        }

        if launch = 0
        {
            if move_v <= 0
                draw_sprite_ext(mario_sprite,0,x,y,dir,1,angle,c_white,alpha)
            else
                draw_play_ext(x,y,mario_sprite,0,2,move_v/20.0*(1-global.pause),dir,1,angle,c_white,alpha)
        }

    }

    if gravity_state = 1
    {
        launch = 0
        if !gravity_water
        {
            draw_sprite_ext(mario_sprite,3,x,y,dir,1,angle,c_white,alpha)
            draw_index = 3
        }
        else
        {
            if swim
            {
                var swim_finish;
                swim_finish = draw_play_ext(x,y,mario_sprite,4,7,0.15*(1-global.pause),dir,1,angle,c_white,alpha)
                if swim_finish
                    swim = false
            }
            else
                draw_play_ext(x,y,mario_sprite,7,8,0.1*(1-global.pause),dir,1,angle,c_white,alpha)
        }
    }
}

if crouch && !crouch_fix && change = 0
{
    launch = 0
    draw_sprite_ext(mario_sprite,12,x,y,dir,1,angle,c_white,alpha)
}

if crouch_fix && change = 0
{
    launch = 0
    draw_sprite_ext(mario_sprite,0,x,y,dir,1,angle,c_white,alpha)
}

if change > 0
{
    if !global.pause
        change -= 1

    launch = 0
    draw_play_ext(x,y,mario_sprite,9,11,0.5*(1-global.pause),dir,1,angle,c_white,alpha)
}
*/
