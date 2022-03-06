//md5_check_music(musicname)
var musicext;
if global.musicencrypt
    musicext = global.audiocryptext
else
    musicext = global.audioext

if !file_exists(".\Data\Music"+argument0 + "." + musicext)
    return true;

if !file_exists(".\Data\check.dat")
    return false;

var flist, ftext, fcheck;
flist = file_text_open_read(".\Data\check.dat")
fcheck = file_find_first(".\Data\Music\*",0)
ftext = file_text_read_string(flist)
file_text_readln(flist)
while ( ftext != "********************************" )
{
    if fcheck = argument0 + "." + musicext
    {
        file_text_close(flist)
        var fread, text;
        fread = file_text_open_read(".\Data\Music\"+fcheck)
        text = file_text_read_all(fread)
        file_text_close(fread)
        text += global.checkkey
        text = md5(text)

        if text != ftext
            return false;
        else
            return true;
    }

    fcheck = file_find_next()
    ftext = file_text_read_string(flist)
    file_text_readln(flist)
}

file_text_close(flist)
return true;
