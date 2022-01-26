//__Load_ini(list,map)

var iniID;

// 获取ini的ID，创建ini需要的map
var map;
map = argument1;
iniID = map

// section列表
var secList;
secList = ds_list_create();
ds_map_add(map,2,secList)

// 读取ini文件，并存入map
var exists,iniList;
iniList = argument0

var section,set_map,size,i;
section = ""
set_map = -1
size = ds_list_size(iniList)
for(i = 0;i < size;i += 1) {
    var text;
    text = ds_list_find_value(iniList,i)
    var a,b,c;
    a = string_pos(INI_SECTION_SIGN_LEFT,text)
    b = string_pos(INI_SECTION_SIGN_RIGHT,text)
    c = string_pos(INI_ITEM_SIGN,text)
    // 检查字符串是否符合标准ini格式
    if(text == "") continue
    if(c == 0) {
        if!(a == 1 and b > 2) {
            continue
        }
    }
    // 检查该行是否为注释语句
    if(string_pos(INI_NOTE_SIGN,text) == 1) continue

    if(a == 1 and b > 2) {
        section = string_copy(text,a+1,b-a-1)
        if(!ds_map_exists(map,section)) {
            var m,l;
            m = ds_map_create()
            ds_map_add(map,section,m)
            l[0] = ds_list_create()
            l[1] = ds_list_create()
            ds_map_add(m,0,l[0])
            ds_map_add(m,1,l[1])
            if(ds_list_find_index(secList,section) == -1) {
                ds_list_add(secList,section)
            }
            set_map = m

        } else {
            set_map = ds_map_find_value(map,section)
        }
        continue
    }

    if(c != 0) {
        if(set_map != -1) {
            var left,right,list;
            left = string_copy(text,1,c-1)
            right = string_copy(text,c+1,string_length(text) - c)
            list[0] = ds_map_find_value(set_map,0)
            list[1] = ds_map_find_value(set_map,1)
            ds_list_add(list[0],left)
            ds_list_add(list[1],right)
            show_debug_message("Set Item : [" + section + "] " + left + " : " + right)
        }
    }
}
ds_list_destroy(iniList)
return iniID;
