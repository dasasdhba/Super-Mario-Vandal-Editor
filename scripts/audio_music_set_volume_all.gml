//audio_music_set_volume_all(volume)
var _sndvolume;
if argument_count = 0
    _sndvolume = global.music
else
    _sndvolume = argument0
FMODGroupSetVolume(1,_sndvolume)
