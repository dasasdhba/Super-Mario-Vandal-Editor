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
        block = instance_place_round(x+cosd(block_dir), y-sind(block_dir), o_block_ice)
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
    instance_recover(o_block_ice)
}

return _return;
