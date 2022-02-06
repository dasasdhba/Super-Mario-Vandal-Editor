//gravity_hit_block_down()
globalvar _return;
_return = false

if gravity_hit_down
{
    var block;
    do
    {
        block = instance_place_round(x+cosd(gravity_dir), y-sind(gravity_dir), o_block)
        if block
        {
            if !block.hit
            {
                block.hit = true
                _return = true
            }
            instance_ignore(block)
        }
    }
    until( !block )
    instance_recover()
}


if gravity_v > 0 && gravity_place
{
    var block;
    do
    {
        block = instance_place_round(x, y, o_block)
        if block
        {
            if block.hidden && !place_meeting_round(x-16*cosd(gravity_dir), y+16*sind(gravity_dir), block)
            {
                block.hit = true
                block.hidden = false
                block.type = 0
                block.visible = true
                physics_fix(x,y,gravity_dir+180,1)
                gravity_hit_down = true
                _return = true
            }
            instance_ignore(block)
        }
    }
    until( !block )
    instance_recover()
}

return _return;
