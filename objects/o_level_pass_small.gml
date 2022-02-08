#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
image_speed = 0.5

if instance_number(o_level_pass) > 0 && x > o_level_pass.x + 48
    dir = -1
else
    dir = 1

pass = false
count = 0
fcount = 0
pcount = 0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    if o_mario.pipe = 0 && o_mario.gravity_state = 0 && o_mario.gravity_v = 0
    && !o_mario.pass && !pass && y <= o_mario.y - 30 && y > o_mario.y - 131
    && ( ( dir = 1 && x <= o_mario.x - 24 ) || ( dir = -1 && x >= o_mario.x + 12 ) )
    {
        pcount += 1
        if pcount >= 2
        {
            FMODAllStop()
            var i;
            for(i=0;i<=global.channel_max;i+=1)
            {
                global.musicplay[i] = 0
                global.musicname[i] = ""
            }
            audio_sound_play("level_pass")

            pass = true
            o_level_pass_line.stop = true

            var s;
            s = instance_create(o_mario.x, o_mario.y-42, o_score)
            s.scores = 100
        }
    }
    else
        pcount = 0

    if pass
    {
        o_mario.dir = dir
        o_mario.velocity = 16

        with(o_mario)
        {
            control = false
            invincible = true
            fall = false
            pass = true
        }

        with(o_fireball_mario)
        {
            var s;
            s = instance_create(x,y,o_score)
            s.scores = 100

            instance_destroy()
        }

        with(o_beet_mario)
        {
            var s;
            s = instance_create(x,y,o_score)
            s.scores = 200

            instance_destroy()
        }

        o_camera.screen_limit = false

        if count < 400
            count += 1

        if count >= 400
        {
            fcount += 1
            if global.time > 0 && ( fcount mod 5 ) = 0
                audio_sound_play("time")

            if global.time > 0
            {
                global.scores += 10
                global.time -= 1
            }
            if global.time > 0
            {
                global.scores += 10
                global.time -= 1
            }
            if global.time > 0
            {
                global.scores += 10
                global.time -= 1
            }
            if global.time > 0
            {
                global.scores += 10
                global.time -= 1
            }

            if global.time <= 0
                count += 1

            if count >= 500
            {
                FMODAllStop()
                global.musicplay = 0
                global.musicname = ""

                global.checkpoint = 0
                global.checkroom = 0
                global.deathroom = 0
                global.oneoff = false
                global.time = -1

                room_goto_next()
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
