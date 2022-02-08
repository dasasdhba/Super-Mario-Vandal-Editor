#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
pause = -1

physics_init()
gravity_state = -1
gravity_place = false
gravity_a = 0.2
gravity_d = 0.2
gravity_a_water = 0.2
gravity_d_water = 0.2
gravity_max_water = 10
move_place = false
move_v = 30/8.0
move_dir = 270

yorigin = y
height = 224

stop = false
fly = false
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    if !stop
    {
        if ( move_dir = 270 && y >= yorigin + height ) || ( move_dir = 90 && y <= yorigin )
            move_dir += 180

        physics_step()

        if place_meeting(x,y,o_mario)
        {
            FMODAllStop()
            var i;
            for(i=0;i<=global.channel_max;i+=1)
            {
                global.musicplay[i] = 0
                global.musicname[i] = ""
            }
            audio_sound_play("level_pass")

            if instance_number(o_level_pass_small) = 0
            {
                var p;
                p = instance_create(-32, -32, o_level_pass_small)
                p.dir = 1
                p.pass = true
            }
            else
                o_level_pass_small.pass = true

            var s;
            if y <= yorigin + 20
                instance_create(x,y,o_life)
            else
            {
                s = instance_create(x,y,o_score)
                if y <= yorigin + 50
                    s.scores = 5000
                else if y <= yorigin + 90
                    s.scores = 2000
                else if y <= yorigin + 140
                    s.scores = 1000
                else if y <= yorigin + 190
                    s.scores = 500
                else
                    s.scores = 200
            }

            stop = true
            fly = true

            gravity_state = 1
            move_v = 5
            if o_level_pass_small.dir = 1
                move_dir = ( 11 + irandom(2) ) * 11.25
            else
                move_dir = ( 3 + irandom(2) ) * 11.25

        }

    }

    if fly
    {
        image_index = 1
        physics_step()

        image_angle -= o_level_pass_small.dir * 15

        var f_height;
        f_height = sprite_height + 64
        if ( ( gravity_dir >= 225 && gravity_dir <= 315 ) && y >= room_height + f_height )
        || ( ( gravity_dir >= 45 && gravity_dir <= 135 ) && y <= 0 - f_height )
        || ( ( gravity_dir >= 135 && gravity_dir <= 225 ) && x <= 0 - f_height )
        || ( ( gravity_dir >= 315 || gravity_dir <= 45 ) && x >= room_width + f_height )
            instance_destroy()
    }
    else
        image_index = 0

}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !out_of_frame(64)
    draw_self()
