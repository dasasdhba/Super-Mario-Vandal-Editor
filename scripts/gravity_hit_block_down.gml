//gravity_hit_block_down()
globalvar _return;
_return = false

if gravity_hit_down
{
    globalvar _self;
    _self = id
    with(o_block)
    {
        if !hit && place_meeting_round(x-cosd(_self.gravity_dir), y+sind(_self.gravity_dir), _self)
        {
            hit = true
            _return = true
        }
    }
}


if gravity_v > 0 && gravity_place
{
    globalvar _self;
    _self = id
    with(o_block)
    {
        if hidden && place_meeting_round(x, y, _self) && !place_meeting_round(x+16*cosd(_self.gravity_dir), y-16*sind(_self.gravity_dir), _self)
        {
            hit = true
            hidden = false
            type = 0
            visible = true
            with(_self)
            {
                physics_fix(x,y,gravity_dir+180,1)
                gravity_hit_down = true
            }

            _return = true
        }
    }
}

return _return;
