//INI_get_string(string)
var iniMap,secList;
iniMap = argument0
secList = ds_map_find_value(iniMap,2)
var i,size,iniStr;
iniStr = ""
size = ds_list_size(secList)
for(i = 0;i < size;i += 1) {
            var a,section,sMap;
            section = ds_list_find_value(secList,i)
            iniStr += INI_SECTION_SIGN_LEFT + section + INI_SECTION_SIGN_RIGHT
            iniStr += (chr(13) + chr(10))
            sMap = ds_map_find_value(iniMap,section)
            var itemCount,l;
            l[0] = ds_map_find_value(sMap,0)
            l[1] = ds_map_find_value(sMap,1)
            itemCount = ds_list_size(l[0])
            for(a = 0;a < itemCount;a += 1) {
                iniStr += ds_list_find_value(l[0],a) + INI_ITEM_SIGN + ds_list_find_value(l[1],a)
                iniStr += (chr(13) + chr(10))
            }
}
return iniStr;
