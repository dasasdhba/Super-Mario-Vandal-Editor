//gravity_hit_ice_up()
globalvar _return;
_return = false

if gravity_hit_up
{
    var block;
    do
    {
        block = instance_place_round(x-cosd(gravity_dir), y+sind(gravity_dir), o_block_ice)
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
