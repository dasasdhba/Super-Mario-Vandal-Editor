//INI_read(ini,section,key/pos,default)
var ini,section,key,def;
ini = argument0
section = argument1
key = argument2
def = argument3

var sMap;
if(ds_map_exists(ini,section)) {
    sMap = ds_map_find_value(ini,section)
    var l,index;
    l[0] = ds_map_find_value(sMap,0)
    l[1] = ds_map_find_value(sMap,1)
    if(is_string(key)) {
        index = ds_list_find_index(l[0],key)
        if(index = -1) return def
    } else {
        index = key - 1;
    }
    return ds_list_find_value(l[1],index)
} else {
    return def;
}
