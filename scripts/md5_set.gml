//md5_set()
//set the MD5 list file in debug mode

if debug_mode
{
    file_delete(".\Data\check.dat")

    var fcheck, fwrite;
    fwrite = file_text_open_write(".\Data\check.dat")
    fcheck = file_find_first(".\Data\Sound\*",0)
    while ( fcheck != "" )
    {
        var fread, text;
        fread = file_text_open_read(".\Data\Sound\"+fcheck)
        text = file_text_read_all(fread)
        file_text_close(fread)
        text += global.checkkey
        file_text_write_string(fwrite, md5(text))
        file_text_writeln(fwrite)

        fcheck = file_find_next()
    }

    file_text_write_string(fwrite, "********************************")
    file_text_writeln(fwrite)

    fcheck = file_find_first(".\Data\Music\*",0)
    while ( fcheck != "" )
    {
        var fread, text;
        fread = file_text_open_read(".\Data\Music\"+fcheck)
        text = file_text_read_all(fread)
        file_text_close(fread)
        text += global.checkkey
        file_text_write_string(fwrite, md5(text))
        file_text_writeln(fwrite)

        fcheck = file_find_next()
    }

    file_text_write_string(fwrite, "********************************")
    file_text_close(fwrite)

}

return true;
