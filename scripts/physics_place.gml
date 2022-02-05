//physics_place(x,y,setting,depth)
/*setting
= 0 or other: detect solid and platform and return true or false
= 1: detect solid and return true or false
= 2: detect platform and return true or false

depth is for platform
*/

var place_set, place_depth;
if argument_count >= 3
    place_set = argument2
else
    place_set = 0

if argument_count = 4
    place_depth = argument3
else
    place_depth = 0

if place_set != 2
{
    globalvar _self,_xorigin,_yorigin;
    _self = id
    _xorigin = x
    _yorigin = y
    x = mround(argument0)
    y = mround(argument1)
    with(o_solid)
    {
        if place_meeting(x,y,_self) && ( type = 0 || type = _self.phy_type )
        {
            _self.x = _xorigin
            _self.y = _yorigin
            return true;
        }
    }

    x = _xorigin
    y = _yorigin

}

if place_set != 1
{
    globalvar _self, _xorigin, _yorigin, _depth;
    _self = id
    _xorigin = x
    _yorigin = y
    _depth = place_depth
    with(o_platform)
    {
        _self.x = mround(argument0)
        _self.y = mround(argument1)
        if place_meeting(x,y,_self) && ( type = 0 || type = _self.phy_type )
        {
            if _depth <= 0
            {
                _self.x = _xorigin
                _self.y = _yorigin
                return true;
            }
            else
            {
                _self.x = mround(argument0-_depth*cosd(_self.gravity_dir))
                _self.y = mround(argument1+_depth*sind(_self.gravity_dir))
                if !place_meeting(x,y,_self)
                {
                    _self.x = _xorigin
                    _self.y = _yorigin
                    return true;
                }
            }
        }
    }

    x = _xorigin
    y = _yorigin

}

return false;
