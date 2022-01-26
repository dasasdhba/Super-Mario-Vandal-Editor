//draw_sprite_part_rot(spr,subimg,x,y,left,top,width,height,rot)
var _dx, _dy, _ox, _oy;
_ox = sprite_get_xoffset(argument0) - argument4
_oy = sprite_get_yoffset(argument0) - argument5
_dx = argument2 - ( _ox*image_xscale*cosd(argument8) + _oy*image_yscale*sind(argument8) )
_dy = argument3 + ( _ox*image_xscale*sind(argument8) - _oy*image_yscale*cosd(argument8) )
draw_sprite_general(argument0, argument1, argument4, argument5, argument6, argument7, _dx, _dy, image_xscale, image_yscale, argument8, c_white, c_white, c_white, c_white, image_alpha)
