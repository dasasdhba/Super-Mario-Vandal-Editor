#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
globalvar _self;
_self = id
with(o_block)
{
    if place_meeting(x,y,_self)
    {
        hidden = true
        type = -1
        visible = false
    }
}

instance_destroy()
