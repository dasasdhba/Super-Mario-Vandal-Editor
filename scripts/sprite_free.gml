//sprite_free()
var i;
for (i=0;i<ds_list_size(global.sprite_list);i+=1)
{
    sprite_delete(ds_list_find_value(global.sprite_list,i))
    ds_list_delete(global.sprite_list,i)
    i -= 1
}
