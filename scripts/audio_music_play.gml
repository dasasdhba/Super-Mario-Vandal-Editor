//audio_music_play(musicstr,loop,volume)
//load the music file to FMOD System Group 1 and play it immediately
//the default volume is global.music
//return the FMOD instance
if !md5_check_music(argument0)
    game_end()

var _loop, _sndvolume, _snd, _instance;
if argument_count >= 2
    _loop = argument1
else
    _loop = 0

if argument_count = 3
    _sndvolume = argument2
else
    _sndvolume = global.music


var fmusic, snd;
if global.musicencrypt
{
    fmusic = ".\Data\Music\"+argument0+"."+global.audiocryptext
    var fnew;
    fnew = ".\Data\Save\"+argument0+"."+global.audiocryptext
    file_copy(fmusic,fnew)
    file_crypt_text(fnew,global.audiokey)
    _snd = FMODSoundAdd(fnew)
    file_delete(fnew)
}
else
{
    fmusic = ".\Data\Music\"+argument0+"."+global.audioext
    _snd = FMODSoundAdd(fmusic)
}
FMODSoundSetGroup(_snd,1)

_instance = FMODSoundLoop(_snd)
FMODInstanceSetVolume(_instance, _sndvolume)
FMODInstanceSetLoopCount(_instance, _loop)

ds_list_add(global.music_id_list, _snd)
ds_list_add(global.music_instance_list, _instance)

return _instance;
