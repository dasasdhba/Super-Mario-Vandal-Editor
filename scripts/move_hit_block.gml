//move_hit_block()
globalvar _return;
_return = false

if move_hit
{
    var block, block_dir;
    if move_mode = 1
        block_dir = move_dir + 180
    else
        block_dir = move_dir
    do
    {
        block = instance_place_round(x+cosd(block_dir), y-sind(block_dir), o_block)
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

if !_return && move_v > 0 && move_place
{
    var block;
    do
    {
         block = instance_place_round(x, y, o_block)
         if block
         {
            if block.hidden && !place_meeting_round(x-16*cosd(move_dir), y+16*sind(move_dir), block)
            {
                block.hit = true
                block.hidden = false
                block.type = 0
                block.visible = true
                physics_fix(x,y,move_dir+180,1)

                _return = true
            }
            instance_ignore(block)

         }
    }
    until( !block )
    instance_recover()
    if _return
    {
        switch (move_mode)
        {
            case 0: move_v = 0; break;
            case 1: move_dir += 180; break;
            case 2: move_hit_ext = true; break;
            default: break;
        }
    }
}

return _return;
