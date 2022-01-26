//audio_sound_init()
//load all the sound files to FMOD System Group 2
var fcheck;
if !global.soundencrypt
    fcheck = file_find_first(".\Data\Sound\*."+global.audioext,0)
else
    fcheck = file_find_first(".\Data\Sound\*."+global.audiocryptext,0)
while ( fcheck != "" )
{
    var fmusic, snd;
    fmusic = ".\Data\Sound\"+fcheck
    if global.soundencrypt
    {
        var fnew;
        fnew = ".\Data\Save\"+fcheck
        file_copy(fmusic,fnew)
        file_crypt_text(fnew,global.audiokey)
        snd = FMODSoundAdd(fnew)
        file_delete(fnew)
        fcheck = filename_change_ext(fcheck,"."+global.audioext)
    }
    else
        snd = FMODSoundAdd(fmusic)
    FMODSoundSetGroup(snd,2)
    variable_global_set("_snd"+fcheck,snd)

    fcheck = file_find_next()
}
