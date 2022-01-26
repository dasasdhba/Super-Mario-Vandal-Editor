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
    var place_obj;
    place_obj = instance_place_round(argument0,argument1,o_solid)
    if ( place_obj && ( place_obj.type = 0 || place_obj.type = phy_type ) )
        return true;
}

if place_set != 1
{
    globalvar _self, _depth;
    _self = id
    _depth = place_depth
    with(o_platform)
    {
        var place_self,place_xorigin,place_yorigin;
        place_self = _self
        place_xorigin = place_self.x
        place_yorigin = place_self.y
        place_self.x = mround(argument0)
        place_self.y = mround(argument1)
        if ( place_meeting(x,y,place_self) && ( type = 0 || type = place_self.phy_type ) )
        {
            if _depth <= 0
            {
                place_self.x = place_xorigin
                place_self.y = place_yorigin
                return true;
            }
            else
            {
                place_self.x = mround(argument0-_depth*cosd(place_self.gravity_dir))
                place_self.y = mround(argument1+_depth*sind(place_self.gravity_dir))
                if !place_meeting(x,y,place_self)
                {
                    place_self.x = place_xorigin
                    place_self.y = place_yorigin
                    return true;
                }
            }
        }

        place_self.x = place_xorigin
        place_self.y = place_yorigin
    }

}

return false;
