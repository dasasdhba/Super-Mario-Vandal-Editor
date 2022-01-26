//audio_encrypt()
//encrypt the audio file in debug mode
if debug_mode
{
    var fcheck;
    fcheck = file_find_first(".\Data\Sound\*",0)
    while ( fcheck != "" )
    {
        if global.soundencrypt
        {
            if filename_ext(fcheck) != "."+global.audiocryptext
            {
                file_crypt_text(".\Data\Sound\"+fcheck,global.audiokey)
                var fname;
                fname = filename_change_ext(fcheck,"."+global.audiocryptext)
                file_rename(".\Data\Sound\"+fcheck,".\Data\Sound\"+fname)
            }
        }
        else
        {
            if filename_ext(fcheck) = "."+global.audiocryptext
                file_crypt_text(".\Data\Sound\"+fcheck,global.audiokey)
            if filename_ext(fcheck) != "."+global.audioext
            {
                var fname;
                fname = filename_change_ext(fcheck,"."+global.audioext)
                file_rename(".\Data\Sound\"+fcheck,".\Data\Sound\"+fname)
            }
        }

        fcheck = file_find_next()
    }

    fcheck = file_find_first(".\Data\Music\*",0)
    while ( fcheck != "" )
    {
        if global.musicencrypt
        {
            if filename_ext(fcheck) != "."+global.audiocryptext
            {
                file_crypt_text(".\Data\Music\"+fcheck,global.audiokey)
                var fname;
                fname = filename_change_ext(fcheck,"."+global.audiocryptext)
                file_rename(".\Data\Music\"+fcheck,".\Data\Music\"+fname)
            }
        }
        else
        {
            if filename_ext(fcheck) = "."+global.audiocryptext
                file_crypt_text(".\Data\Music\"+fcheck,global.audiokey)
            if filename_ext(fcheck) != "."+global.audioext
            {
                var fname;
                fname = filename_change_ext(fcheck,"."+global.audioext)
                file_rename(".\Data\Music\"+fcheck,".\Data\Music\"+fname)
            }
        }

        fcheck = file_find_next()
    }
}
