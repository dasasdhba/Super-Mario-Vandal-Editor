//INI_key_delete_n(ini,section,key,n)
var ini,section,key,n;
ini = argument0
section = argument1
key = argument2
n = argument3

n -= 1
var sMap;
if(ds_map_exists(ini,section)) {
    sMap = ds_map_find_value(ini,section)
    var l,index;
    l[0] = ds_map_find_value(sMap,0)
    l[1] = ds_map_find_value(sMap,1)
    var a,i,size;
    size = ds_list_size(l[0])
    a = 0
    for(i = 0;i < size;i += 1) {
        var k,v;
        k = ds_list_find_value(l[0],i)
        if(k == key) {
            if(a == n) {
                ds_list_delete(l[0],i)
                ds_list_delete(l[1],i)
            }
            a += 1
        }
    }
    ds_map_replace(ini,1,true)
    return 1;
} else {
    return 0;
}
