//INI_write(ini,section,key,value)
var ini,section,key,value;
ini = argument0
section = argument1
key = argument2
value = argument3
if(is_real(section)) section = string(section)
if(is_real(key)) key = string(key)
if(is_real(value)) value = string(value)

var sMap,l;
if(!ds_map_exists(ini,section)) {
    var m,l,secList;
    m = ds_map_create();
    sMap = m
    l[0] = ds_list_create()
    l[1] = ds_list_create()
    ds_map_add(ini,section,m)
    ds_map_add(m,0,l[0])
    ds_map_add(m,1,l[1])
    secList = ds_map_find_value(ini,2)
    ds_list_add(secList,section)
} else {
    sMap = ds_map_find_value(ini,section)
    l[0] = ds_map_find_value(sMap,0)
    l[1] = ds_map_find_value(sMap,1)
}
var index;
index = ds_list_find_index(l[0],key)
if(index = -1) {
    ds_list_add(l[0],key)
    ds_list_add(l[1],value)
} else {
    ds_list_replace(l[0],index,key)
    ds_list_replace(l[1],index,value)
}

ds_map_replace(ini,1,true)
