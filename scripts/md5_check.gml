//md5_check()
//check whether the external file's MD5 is right

if !file_exists(".\Data\check.dat")
    return false;

var flist, ftext, fcheck;
flist = file_text_open_read(".\Data\check.dat")
fcheck = file_find_first(".\Data\Sound\*",0)
ftext = file_text_read_string(flist)
file_text_readln(flist)
while ( ftext != "********************************" )
{
    if fcheck = ""
    {
        file_text_close(flist)
        return false;
    }

    var fread, text;
    fread = file_text_open_read(".\Data\Sound\"+fcheck)
    text = file_text_read_all(fread)
    file_text_close(fread)
    text += global.checkkey
    text = md5(text)

    if text != ftext
    {
        file_text_close(flist)
        return false;
    }

    fcheck = file_find_next()
    ftext = file_text_read_string(flist)
    file_text_readln(flist)
}

fcheck = file_find_first(".\Data\Music\*",0)
ftext = file_text_read_string(flist)
file_text_readln(flist)
while ( ftext != "********************************" )
{
    if fcheck = ""
    {
        file_text_close(flist)
        return false;
    }

    var fread, text;
    fread = file_text_open_read(".\Data\Music\"+fcheck)
    text = file_text_read_all(fread)
    file_text_close(fread)
    text += global.checkkey
    text = md5(text)

    if text != ftext
    {
        file_text_close(flist)
        return false;
    }

    fcheck = file_find_next()
    ftext = file_text_read_string(flist)
    file_text_readln(flist)
}

file_text_close(flist)
return true;
