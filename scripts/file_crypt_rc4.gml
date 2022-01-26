//file_crypt_rc4(fname,key)
var fbin, fread, i, j, k, S;
if !file_exists(argument0)
    return false;

for (i=0;i<256;i+=1) S[i] = i;

var klen;
klen = string_length(argument1)
j = 0
for (i=0;i<256;i+=1)
{
    j = ( j + S[i] + ord(string_char_at(argument1, (i mod klen)+1)) ) mod 256
    var temp;
    temp = S[i]
    S[i] = S[j]
    S[j] = temp
}

i = 0
j = 0

fbin = file_bin_open(argument0, 2)

file_bin_seek(fbin, 0)
repeat(file_bin_size(fbin))
{
    i = ( i+1 ) mod 256
    j = ( j+S[i] ) mod 256
    var temp;
    temp = S[i]
    S[i] = S[j]
    S[j] = temp
    k = ( S[i]+S[j] ) mod 256

    fread = file_bin_read_byte(fbin)
    file_bin_seek(fbin, file_bin_position(fbin)-1)
    file_bin_write_byte(fbin, fread ^ S[k])
}

file_bin_close(fbin)
return true;
