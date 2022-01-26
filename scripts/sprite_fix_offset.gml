//sprite_fix_offset(xoff,yoff,spr)
//duplicate a new sprite with a new offset and fix the object's position at the same time
//the default spr is self's
var _spr,_xoff,_yoff,_exist,_new;
if argument_count = 3
    _spr = argument2
else
    _spr = sprite_index
_xoff = sprite_get_xoffset(_spr)
_yoff = sprite_get_yoffset(_spr)

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

sprite_index = _new
x += (argument0 - _xoff)*image_xscale*cosd(image_angle) + (argument1 - _yoff)*image_yscale*sind(image_angle)
y -= (argument0 - _xoff)*image_xscale*sind(image_angle) - (argument1 - _yoff)*image_yscale*cosd(image_angle)

return _new;
