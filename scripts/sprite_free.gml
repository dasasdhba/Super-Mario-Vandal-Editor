//sprite_free()
var i;
for (i=0;i<ds_list_size(global.sprite_list);i+=1)
{
    globalvar _sfree,_scheck;
    _sfree = true
    _scheck = ds_list_find_value(global.sprite_list, i)
    with (all)
    {
        if sprite_index = _scheck
        {
            _sfree = false
            break;
        }
    }

    if _sfree
    {
        var _xoff,_yoff;
        _xoff = sprite_get_xoffset(_scheck)
        _yoff = sprite_get_yoffset(_scheck)
        sprite_delete(_scheck)
        ds_list_delete(global.sprite_list, i)
        i -= 1
    }
}
