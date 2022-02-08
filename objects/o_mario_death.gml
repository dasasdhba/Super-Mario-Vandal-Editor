#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
physics_init()

gravity_place = false
gravity_state = -1
gravity_a = 0.4
gravity_d = 0.4
gravity_a_water = 0.4
gravity_d_water = 0.4
gravity_max_water = 10
move_state = -1

count = 0
angle = 0

with(o_camera)
{
    instance_destroy()
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    if count = 0
    {
        audio_music_stop_all()
        audio_sound_play("death")
        var i;
        for(i=0;i<=global.channel_max;i+=1)
        {
            global.musicplay[i] = 0
            global.musicname[i] = ""
        }
    }

    count += 1

    if count = 35
    {
        audio_sound_play("death_song")
        gravity_v = -10
        gravity_state = 1
    }

    if count >= 35
        physics_step()

    if count = 150 && is_real(global.life)
        if global.life = 0
            instance_create(x,y,o_gameover)

    if count = 200 && instance_number(o_gameover) = 0
    {
        FMODAllStop()
        global.mario = 0
        global.time = -1
        global.oneoff = true
        global.deathroom = room
        global.checkpoint *= -1
        if is_real(global.life)
            global.life -= 1
        room_goto(r_restart)
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
