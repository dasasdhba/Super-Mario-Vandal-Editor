//INI_close(iniHandle)
var iniMap,isChange,secList,is_file;
iniMap = argument0
isChange = ds_map_find_value(iniMap,1)
secList = ds_map_find_value(iniMap,2)
if(is_real(ds_map_find_value(iniMap,0))) is_file = false else is_file = true

if(isChange) {
    if(is_file) {
        /*var file,fname;
        fname = ds_map_find_value(iniMap,0)
        file = file_text_open_write(fname)
        var i,size;
        size = ds_list_size(secList)
        for(i = 0;i < size;i += 1) {
            var a,section,sMap;
            section = ds_list_find_value(secList,i)
            file_text_write_string(file,"[" + section + "]")
            file_text_writeln(file)
            sMap = ds_map_find_value(iniMap,section)
            var itemCount,l;
            l[0] = ds_map_find_value(sMap,0)
            l[1] = ds_map_find_value(sMap,1)
            itemCount = ds_list_size(l[0])
            for(a = 0;a < itemCount;a += 1) {
                file_text_write_string(file,ds_list_find_value(l[0],a) + "=" + ds_list_find_value(l[1],a))
                file_text_writeln(file)
            }
        }
        file_text_close(file)*/
        var fname;
        fname = ds_map_find_value(iniMap,0)
        INI_save_file(iniMap,fname)
    } else {
        var iniStr;
        iniStr = ""
        iniStr = INI_get_string(iniMap)
    }
}

var i,sMap,size;
size = ds_list_size(secList)
for(i = 0;i < size;i += 1) {
    sMap = ds_map_find_value(iniMap,ds_list_find_value(secList,i))
    ds_list_destroy(ds_map_find_value(sMap,0))
    ds_list_destroy(ds_map_find_value(sMap,1))
    ds_map_destroy(sMap)
}
ds_list_destroy(secList)
ds_map_destroy(iniMap)

if(is_file) {
    return 1
} else {
    return iniStr;
}
