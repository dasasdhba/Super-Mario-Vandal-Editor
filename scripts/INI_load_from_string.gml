// INI_load_from_string(string) : iniHandle
// open a ini file and return the ini file ID
// if error return -1

/*
    ini MAP的保存方式
    0 : ini的文件位置
    1 : ini是否被更改
    2 : section列表的索引
*/

var iniStr ;
iniStr = argument0
if(is_real(iniStr)) {
    global.__ini_error_string = "argument must be a string";
    return -1;
}
var iniID;

// 获取ini的ID，创建ini需要的map
var map;
map = ds_map_create();
iniID = map

// 将路径存入到map,key=0存储的是ini的文件路径
ds_map_add(map,0,0)

// 该ini文件是否被修改
ds_map_add(map,1,false)

// 读取ini文件，并存入map
var list;
list = ds_list_create()

var i,length,section,set_map;
section = ""
text = ""
set_map = -1
length = string_length(iniStr)
for(i = 1;i <= length;i += 1) {
    var char;
    char = string_copy(iniStr,i,1)
    if(char == chr(13) or char == chr(10)) {
        if(text != "") {
            ds_list_add(list,text)
            text = ""
        }
    } else {
        text += char
    }
}
if(text != "") {
    ds_list_add(list,text)
}

__Load_ini(list,iniID)
return iniID;
