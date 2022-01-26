//draw_background_inframe(back,x,y,xscale,yscale,colour,alpha)
var _left,_right,_top,_bottom;
_left = min(argument1, argument1 + background_get_width(argument0)*argument3)
_right = max(argument1, argument1 + background_get_width(argument0)*argument3)
_top = min(argument2, argument2 + background_get_height(argument0)*argument4)
_bottom = max(argument2, argument2 + background_get_height(argument0)*argument4)

if _left < view_xview[0] + view_wview[0] && _right > view_xview[0]
&& _top < view_yview[0] + view_hview[0] && _bottom > view_yview[0]
{
    draw_background_ext(argument0, argument1, argument2, argument3, argument4, 0, argument5, argument6)
    return true;
}
return false;
