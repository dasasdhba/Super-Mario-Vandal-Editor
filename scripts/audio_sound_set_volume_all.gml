//audio_sound_set_volume_all(volume)
var _sndvolume;
if argument_count = 0
    _sndvolume = global.sound
else
    _sndvolume = argument0
FMODGroupSetVolume(2,_sndvolume)
