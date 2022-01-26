//INI_key_same_count(ini,section,key)
var sMap;
sMap = ds_map_find_value(argument0,argument1)
var l,key;
l = ds_map_find_value(sMap,0)
key = argument2
var i,size,t;
t = 0
size = ds_list_size(l)
for(i = 0;i < size;i += 1) {
    var k;
    k = ds_list_find_value(l,i)
    if(k == key) {
        t += 1
    }
}
return t;
