//draw_sprite_part_rot_ext(spr,subimg,x,y,left,top,width,height,rot,xscale,yscale,alpha)
var _dx, _dy, _ox, _oy;
_ox = sprite_get_xoffset(argument0) - argument4
_oy = sprite_get_yoffset(argument0) - argument5
_dx = argument2 - ( _ox*argument9*cosd(argument8) + _oy*argument10*sind(argument8) )
_dy = argument3 + ( _ox*argument9*sind(argument8) - _oy*argument10*cosd(argument8) )
draw_sprite_general(argument0, argument1, argument4, argument5, argument6, argument7, _dx, _dy, argument9, argument10, argument8, c_white, c_white, c_white, c_white, argument11)
