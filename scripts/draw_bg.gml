//draw_bg(back,x,y,xscale,yscale,htiled,vtild,colour,alpha)
draw_background_inframe(argument0, argument1, argument2, argument3, argument4, argument7, argument8)
if argument5
{
    var _width,_cx;
    _width = background_get_width(argument0)*abs(argument3)
    _cx = argument1 + ceil((view_xview[0]-argument1)/_width)*_width
    draw_background_inframe(argument0, _cx, argument2, argument3, argument4, argument7, argument8)

    var i;
    i = 1
    while( draw_background_inframe(argument0, _cx+i*_width, argument2, argument3, argument4, argument7, argument8) )
        i += 1

    i = -1
    while( draw_background_inframe(argument0, _cx+i*_width, argument2, argument3, argument4, argument7, argument8) )
        i -= 1
}
if argument6
{
    var _height,_cy;
    _height = background_get_height(argument0)*abs(argument4)
    _cy = argument2 + ceil((view_yview[0]-argument2)/_height)*_height
    draw_background_inframe(argument0, argument1, _cy, argument3, argument4, argument7, argument8)

    var i;
    i = 1
    while( draw_background_inframe(argument0, argument1, _cy+i*_height, argument3, argument4, argument7, argument8) )
        i += 1

    i = -1
    while( draw_background_inframe(argument0, argument1, _cy+i*_height, argument3, argument4, argument7, argument8) )
        i -= 1
}
