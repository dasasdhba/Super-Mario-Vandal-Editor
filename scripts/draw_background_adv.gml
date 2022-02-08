//draw_background_adv(back,x,y,xscale,yscale,htiled,vtild,colour,alpha)
if argument3 != 0 && argument4 != 0
{
    if argument5 && argument6
    {
        draw_background_tiled_ext(argument0,argument1,argument3,argument3,argument4,argument7,argument8)
        return true;
    }

    if argument5
    {
        var _width,_cx;
        _width = background_get_width(argument0)*abs(argument3)
        _cx = argument1 + floor((view_xview[0]-argument1)/_width)*_width

        var i,j;
        if argument3 > 0
            j = 0
        else
            j = 1
        i = j
        while( _cx+(i-j)*_width < view_xview[0] + view_wview[0] )
        {
            draw_background_ext(argument0, _cx+i*_width, argument2, argument3, argument4, 0, argument7, argument8)
            i += 1
        }

    }
    else if argument6
    {
        var _height,_cy;
        _height = background_get_height(argument0)*abs(argument4)
        _cy = argument2 + floor((view_yview[0]-argument2)/_height)*_height

        var i,j;
        if argument4 > 0
            j = 0
        else
            j = 1
        i = j
        while( _cy+(i-j)*_height < view_yview[0] + view_hview[0] )
        {
            draw_background_ext(argument0, argument1, _cy+i*_height, argument3, argument4, 0, argument7, argument8)
            i += 1
        }

    }
    else
    {
        draw_background_ext(argument0, argument1, argument2, argument3, argument4, 0, argument7, argument8)
        return true;
    }
}
return false;
