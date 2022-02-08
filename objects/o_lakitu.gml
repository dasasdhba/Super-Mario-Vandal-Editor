#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_user(0)
turn = false
hurt = false
def_lava = -1

sprite_fix_offset(15,47)
image_speed = 0
image_angle = 0

instance_init()
physics_init()
pause = -1
phy_type = 2
gravity_state = -1
gravity_place = false
gravity_dir = 270
gravity_a = 0.4
gravity_d = 0.4
gravity_a_water= 0.4
gravity_d_water= 0.4
move_place = false

v_max = 9
v_min = 4
a_max = 1
a_min = 0.2
turn_max = 100
turn_min = 50

launch_interval = 170
launch_i_random = 100
launch_time = 10
launch_t_random = 10

reborn = 250
reborn_random = 50
reborn_trim = 16

ani_v = 1

scores = 200

activate = false
death = false

v = 0
state = 0
l_count = 0
r_count = 0
r_random = 0
l_ir = 0
l_tr = 0
ani = 0

yorigin = y
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    //activate
    if instance_number(o_mario) = 0
        activate = false
    else
    {
        var _self;
        _self = id
        with(o_mario)
        {
            if place_meeting_round(x,y,o_lakitu_start)
            {
                _self.activate = true
                _self.v = _self.move_v*(1-_self.move_dir/90)
                _self.l_ir = irandom(_self.launch_i_random)
                _self.l_tr = irandom(_self.launch_t_random)
                _self.r_random = irandom(_self.reborn_random)
            }
            if place_meeting_round(x,y,o_lakitu_stop)
                _self.activate = false
        }
    }

    if !death
    {
        if !activate
        {
            //escape
            v = 0
            if x > view_xview[0] + view_wview[0]/2
            {
                if x < view_xview[0] + view_wview[0] + 32 + sprite_width
                {
                    move_dir = 0
                    move_v = v_min
                }
                else
                    move_v = 0
            }
            else
            {
                if x > view_xview[0] - 32 - sprite_width
                {
                    move_dir = 180
                    move_v = v_min
                }
                else
                    move_v = 0
            }
        }
        else
        {
            //movement
            if x > o_mario.x + turn_min && v > 0 - v_max
                v -= a_min
            if x < o_mario.x - turn_min && v < v_max
                v += a_min
            if x < o_mario.x + turn_max && x > o_mario.x - turn_max
            {
                if o_mario.dir = 1 && v < 0 - v_min
                    v += a_max
                if o_mario.dir = -1 && v > v_min
                    v -= a_max
            }

            if v = 0
                move_v = 0
            else if v > 0
            {
                move_v = v
                move_dir = 0
            }
            else
            {
                move_v = 0 - v
                move_dir = 180
            }

            //launch
            if state = 0 && !out_of_frame(64)
            {
                l_count += 1
                if l_count >= launch_interval + l_ir
                {
                    l_count = 0
                    l_ir = irandom(launch_i_random)
                    state = 1
                }
            }

            if state = 1
            {
                ani += ani_v
                if ani >= 10
                {
                    ani = 10
                    state = 2
                }
            }

            if state = 2
            {
                l_count += 1
                if l_count >= launch_time + l_tr
                {
                    l_count = 0
                    l_tr = irandom(launch_t_random)
                    state = 3
                    audio_sound_play("lakitu_"+string(irandom(2)+1))

                    var ball;
                    ball = instance_create(x,y,o_spiny_ball)
                    ball.x = x
                    ball.y = y - 38*image_yscale
                    ball.image_xscale = image_xscale
                    ball.image_yscale = image_yscale
                    ball.image_angle = image_angle
                    ball.phy_type = phy_type
                    ball.gravity_state = 1
                    ball.gravity_dir = gravity_dir
                    ball.gravity_v = -7
                    ball.solid_check = true
                    ball.activate = true
                }
            }

            if state = 3
            {
                ani -= ani_v
                if ani <= 0
                {
                    ani = 0
                    state = 0
                }
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

            gravity_state = 1
            gravity_v = 0
            move_state = -1
            move_v = 0

            if ( atk > 1 && atk < 5 ) || ( atk = 7 && !out_of_frame(64) )
                audio_sound_play("kick_1")

            atk = 0
            death = true
        }

    }
    else
    {
        if y > view_yview[0] + view_hview[0] + sprite_height + 16
        {
            if reborn <= 0
                instance_destroy()
            else
            {
                r_count += 1
                if r_count >= reborn + r_random
                {
                    r_random = irandom(reborn_random)
                    death = false
                    gravity_state = -1
                    gravity_v = 0
                    move_state = 0
                    if x < view_xview[0] + view_wview[0]/2
                        x = view_xview[0] - sprite_width - 32
                    else
                        x = view_xview[0] + view_wview[0] + sprite_width + 32
                    y = yorigin + irandom_range(0-reborn_trim,reborn_trim)
                }
            }
        }
    }

    physics_step()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !out_of_frame()
{
    if !death
    {
        draw_sprite_ext(sprite_index, 2, x, y+ani*image_yscale, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
        draw_sprite_ext(sprite_index, 1, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
    }
    else
        draw_sprite_ext(sprite_index, 0, x, y-47*image_yscale, image_xscale, 0-image_yscale, image_angle, image_blend, image_alpha)
}
