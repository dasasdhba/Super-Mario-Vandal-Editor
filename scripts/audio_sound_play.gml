//audio_sound_play(sndstr,loop,volume)
//the default volume is global.sound
//return the FMOD instance
var _loop, _sndvolume, _instance;
if argument_count >= 2
    _loop = argument1
else
    _loop = 0

if argument_count = 3
    _sndvolume = argument2
else
    _sndvolume = global.sound

_instance = FMODSoundLoop(variable_global_get("_snd"+argument0+"."+global.audioext))
FMODInstanceSetVolume(_instance, _sndvolume)
FMODInstanceSetLoopCount(_instance, _loop)
return _instance;
