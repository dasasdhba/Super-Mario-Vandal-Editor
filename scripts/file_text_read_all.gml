/// file_text_read_all(file)
//
//  Returns the contents of a given file as a multiline
//  string. Lines are delimited by the "#" character.
//  If the file cannot be read, returns undefined.
//
//
/// GMLscripts.com/license modified by dasasdhba

if (argument0 < 0) return false;
var str, delim;
delim = "#";
str = "";
while (!file_text_eof(argument0))
{
    str += file_text_read_string(argument0);
    str += delim;
    file_text_readln(argument0);
}

return str;
