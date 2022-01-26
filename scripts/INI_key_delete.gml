//INI_key_delete(ini,section,key)
var ini,section,key;
ini = argument0
section = argument1
key = argument2

var sMap;
if(ds_map_exists(ini,section)) {
    sMap = ds_map_find_value(ini,section)
    var l,index;
    l[0] = ds_map_find_value(sMap,0)
    l[1] = ds_map_find_value(sMap,1)
    var a,i,size,deleteCount;
    deleteCount = 0
    size = ds_list_size(l[0])
    a = 0
    for(i = 0;i < size;i += 1) {
        var k;
        k = ds_list_find_value(l[0],i)
        if(k == key) {
            ds_list_delete(l[0],i)
            ds_list_delete(l[1],i)
            i -= 1
            deleteCount += 1
        }
    }
    ds_map_replace(ini,1,true)
    return deleteCount;
} else {
    return 0;
}
