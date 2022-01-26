//INI_section_delete(ini,section)
var ini,section;
ini = argument0
section = argument1

var secList;
secList = ds_map_find_value(ini,2)
ds_list_delete(secList,ds_list_find_index(secList,section))
var sMap,l;
sMap = ds_map_find_value(ini,section)
l[0] = ds_map_find_value(sMap,0)
l[1] = ds_map_find_value(sMap,1)
ds_list_destroy(l[0])
ds_list_destroy(l[1])
ds_map_destroy(sMap)
ds_map_delete(ini,section)
ds_map_replace(ini,1,true)
