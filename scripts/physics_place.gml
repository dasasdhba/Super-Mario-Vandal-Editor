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
    do
    {
        place_obj = instance_place_round(argument0,argument1,o_solid)
        if place_obj
        {
            if place_obj.type = 0 || place_obj.type = phy_type
            {
                instance_recover()
                return true;
            }
            else
                instance_ignore(place_obj)
        }
    }
    until( !place_obj )
    instance_recover()
}

if place_set != 1
{
    var place_obj;
    do
    {
        place_obj = instance_place_round(argument0,argument1,o_platform)
        if place_obj
        {
            if place_obj.type = 0 || place_obj.type = phy_type
            {
                if place_depth <= 0 || !place_meeting_round(argument0-place_depth*cosd(gravity_dir),argument1+place_depth*sind(gravity_dir),place_obj)
                {
                    instance_recover()
                    return true;
                }
                else
                    instance_ignore(place_obj)
            }
            else
                instance_ignore(place_obj)
        }
    }
    until( !place_obj )
    instance_recover()

}

return false;
