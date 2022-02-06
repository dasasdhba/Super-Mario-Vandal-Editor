//instance_recover()
var i;
for(i=0;i<ds_list_size(global.ignore_object);i+=1)
{
    with(ds_list_find_value(global.ignore_object, i))
    {
        _ignore_ = false
        x = _ignore_x_
        ds_list_delete(global.ignore_object, i)
        i -= 1
    }
}
