// INI_open(fname) : iniHandle
// open a ini file and return the ini file ID
// if error return -1

/*
    ini MAP的保存方式
    0 : ini的文件位置
    1 : ini是否被更改
    2 : section列表的索引
*/

var fname ;
fname = argument0
if(is_real(fname)) {
    global.__ini_error_string = "fname must be a string";
    return -1;
}
var file,iniID;

// 获取ini的ID，创建ini需要的map
var map;
map = ds_map_create();
iniID = map

// 将路径存入到map,key=0存储的是ini的文件路径
ds_map_add(map,0,fname)

// 该ini文件是否被修改
ds_map_add(map,1,false)

// 读取ini文件，并存入map
var exists,list;
list = ds_list_create()
exists = file_exists(fname)

var section,set_map;
section = ""
set_map = -1
if(exists) {
file = file_text_open_read(fname)
while(!file_text_eof(file)) {
    var text;
    text = file_text_read_string(file)
    file_text_readln(file)
    ds_list_add(list,text)
}
file_text_close(file)
} else ds_map_replace(map,1,true)
__Load_ini(list,iniID)
return iniID;
