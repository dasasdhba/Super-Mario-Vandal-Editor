//sprite_duplicate_offset(xoff,yoff,spr)
//duplicate a new sprite with a new offset
//the default spr is self's
var _spr,_exist,_new;
if argument_count = 3
    _spr = argument2
else
    _spr = sprite_index

_exist = variable_global_get("_spr"+string(_spr)+"x"+string(argument0)+"y"+string(argument1))
if sprite_exists(_exist)
    _new = _exist
else
{
    _new = sprite_duplicate(_spr)
    sprite_set_offset(_new,argument0,argument1)
    ds_list_add(global.sprite_list, _new)
    variable_global_set("_spr"+string(_spr)+"x"+string(argument0)+"y"+string(argument1), _new)
}

return _new;
