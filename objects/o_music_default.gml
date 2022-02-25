#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
pause = -1

music = ""
channel = 0

volume = 1 //based on global.music

//loop setting
loop_start = -1
loop_end = -1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if music != "" && music != global.musicname[channel]
{
    if FMODInstanceIsPlaying(global.musicplay[channel])
        FMODInstanceStop(global.musicplay[channel])

    global.musicname[channel] = music
    global.musicplay[channel] = audio_music_play(music,-1)

    FMODInstanceSetVolume(global.musicplay[channel], volume*global.music)

    if loop_start >= 0 && loop_end > loop_start
        FMODInstanceSetLoopPoints(global.musicplay[channel],loop_start,loop_end)
}

instance_destroy()
