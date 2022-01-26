//INI_save(ini,fname)
var str,file;
str = INI_get_string(argument0)
file = file_text_open_write(argument1)
file_text_write_string(file,str)
file_text_close(file)
