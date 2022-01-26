//move_hit_block()
globalvar _return;
_return = false

if move_hit
{
    globalvar block_dir,_self;
    if move_mode = 1
        block_dir = move_dir + 180
    else
        block_dir = move_dir
    _self = id
    with(o_block)
    {
        if !hit && place_meeting_round(x-cosd(block_dir), y+sind(block_dir), _self)
        {
            hit = true
            _return = true
        }
    }

}

if move_v > 0 && move_place
{
    globalvar _self;
    _self = id
    with(o_block)
    {
        if hidden && place_meeting_round(x, y, _self) && !place_meeting_round(x+16*cosd(_self.move_dir), y-16*sind(_self.move_dir), _self)
        {
            hit = true
            hidden = false
            type = 0
            visible = true
            with(_self)
            {
                physics_fix(x,y,move_dir+180,1)
                switch (move_mode)
                {
                    case 0: move_v = 0; break;
                    case 1: move_v += 180; break;
                    case 2: move_hit_ext = true; break;
                    default: break;
                }
            }

            _return = true
        }
    }

}

return _return;
