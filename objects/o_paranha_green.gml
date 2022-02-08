#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_user(0)

turn = false
def_stomp = -1
def_bump = -1
def_lava = -1

image_speed = 0.2

instance_init()

dir = image_angle + 90
v_in = 1
v_out = 1
remain_in = 70
remain_out = 70
remain_range = 64
fire = 0
fire_interval = 10

scores = 200
activate = false

/*
state = 0: remain out
state = 1: moving in
state = 2: remain in
state = 3: moving out
*/
state = 0
pos = 0
width = sprite_get_width(sprite_index)
height = sprite_get_height(sprite_index)
r_time = 0
f_count = 0
f_time = 0
xorigin = x
yorigin = y
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
        //state 0: remain out
        if state = 0
        {
            pos = 0

            var launch;
            launch = false
            if f_count > 0 || f_time > 0 || ( fire > 0 && f_count != -1 && !out_of_frame(32) )
            {
                r_time = 0
                launch = true
            }

            if launch
            {
                f_time += 1
                if f_time >= fire_interval
                {
                    f_time = 0
                    f_count += 1

                    audio_sound_play("fireball")
                    var fireball;
                    fireball = instance_create(x,y,o_fireball_piranha)
                    fireball.image_xscale = image_xscale
                    fireball.image_yscale = image_yscale
                    if dir >= 45 && dir <= 135
                    {
                        fireball.xspeed = irandom_range(-5, 5)
                        fireball.gravity_v = irandom_range(-12, -8)
                    }
                    else if dir >= 225 && dir <= 315
                    {
                        fireball.xspeed = irandom_range(-5,5)
                        fireball.gravity_v = irandom(3)
                    }
                    else if dir >= 135 && dir <= 225
                    {
                        fireball.xspeed = irandom_range(-8, -5)
                        fireball.gravity_v = irandom_range(-5, 3)
                    }
                    else
                    {
                        fireball.xspeed = irandom_range(5, 8)
                        fireball.gravity_v = irandom_range(-5, 3)
                    }
                }

                if f_count >= fire
                    f_count = -1

            }
            else
            {
                r_time += 1
                if r_time >= remain_out
                {
                    r_time = 0
                    f_count = 0
                    state = 1
                }
            }
        }

        //state 1: moving in
        if state = 1
        {
            pos += v_in
            if pos >= height*image_yscale
            {
                pos = height*image_yscale
                state = 2
            }
        }

        //state 2: remain in
        if state = 2
        {
            pos = height*image_yscale

            var count;
            count = true
            if remain_range > 0 && instance_number(o_mario) > 0
            {
                var distance;
                if dir = 90 || dir = 270
                    distance = abs( o_mario.x-x )
                else
                {
                    var k;
                    k = 0-tand(dir)
                    distance = abs( o_mario.y-y - k*(o_mario.x-x) )/sqrt(k*k+1)
                }

                if distance <= remain_range + sprite_width/4
                    count = false
            }

            if count
            {
                r_time += 1
                if r_time >= remain_in
                {
                    r_time = 0
                    state = 3
                }
            }

        }

        //state 3: moving out
        if state = 3
        {
            pos -= v_out
            if pos <= 0
            {
                pos = 0
                state = 0
            }
        }

        x = xorigin - pos*cosd(dir)
        y = yorigin + pos*sind(dir)

        event_user(1)

        //attacked
        if atk > 1
        {
            if atk < 5
            {
                var s;
                s = instance_create((bbox_left+bbox_right)/2, bbox_top, o_score)
                s.scores = scores
            }

            if atk < 5 || ( atk = 7 && !out_of_frame(64) )
                audio_sound_play("kick_1")

            instance_destroy()
        }

    }

}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    if o_mario.pipe > 6 && o_mario.pipe < 11 && ( place_meeting(x,y,o_mario) || place_meeting(x-32*cosd(dir),y+32*sind(dir),o_mario) || place_meeting(x+32*cosd(dir),y-32*sind(dir),o_mario)  )
    {
        state = 2
        pos = height*image_yscale
        r_time = 0
    }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !out_of_frame(96)
    draw_sprite_part_rot(sprite_index, image_index, x, y, 0, 0, width, height-(pos/image_yscale), image_angle)
