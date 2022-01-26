//file_crypt_text(fname,key)
var fbin, fread, kpos;
if !file_exists(argument0)
    return false;

kpos = 1
fbin = file_bin_open(argument0, 2)
file_bin_seek(fbin, 0)
repeat(file_bin_size(fbin))
{
    var kord;
    kord = ord(string_char_at(argument1, kpos))
    kpos += 1
    if kpos > string_length(argument1)
        kpos = 1

    fread = file_bin_read_byte(fbin)
    file_bin_seek(fbin, file_bin_position(fbin)-1)
    file_bin_write_byte(fbin, fread ^ kord)
}

file_bin_close(fbin)
return true;
