//physics_free()
var i;
for(i=0;i<ds_list_size(global.physics_object);i+=1)
{
    if !instance_exists(ds_list_find_value(global.physics_object,i))
    {
        ds_list_delete(global.physics_object,i)
        i -= 1
    }
}
