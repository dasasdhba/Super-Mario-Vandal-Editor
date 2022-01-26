/// file_text_write_all(file,str)
//
//  Writes a multiline string to a given argument0.
//  Lines are delimited by the "#" character.
//  Returns true if successful, false otherwise.
//
//      fname       argument0 to write, string
//      str         contents to write, string
//
/// GMLscripts.com/license modified by dasasdhba

if (argument0 < 0) return false;
var str;
str = argument1;
while (string_length(str) > 0)
{
    var i;
    i = string_pos("#", str);
    if (i > 0)
    {
        file_text_write_string(argument0,string_copy(str, 1, i-1));
        file_text_writeln(argument0);
        str = string_delete(str, 1, i);
    }
    else
    {
        file_text_write_string(argument0, str);
        str = "";
    }
}

return true;
