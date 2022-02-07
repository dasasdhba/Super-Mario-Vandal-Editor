#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
pause = -1
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause && o_mario.pipe = 5 && place_meeting(x,y,o_mario)
{
    o_mario.pipe = -1

    FMODAllStop()
    global.musicplay = 0
    global.musicname = ""
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
}
