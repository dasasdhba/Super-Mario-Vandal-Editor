//physics_moving_fix()

//solid_moving fix
var block;
do
{
    block = instance_place_round(x,y,o_solid_moving)
    if block
    {
        if block.type = 0 || block.type = phy_type
        {
            if place_meeting_round(x,y+block.dy,block)
            {
                block.y -= block.dy
                var _place_fix;
                if block.dx > 0
                {
                    _place_fix = physics_fix(x,y,0,1,block.dx)
                    physics_moving_R = true
                }
                else
                {
                    _place_fix = physics_fix(x,y,180,1,0-block.dx)
                    physics_moving_L = true
                }
                if !_place_fix
                    solid_crush = true
                block.y += block.dy
            }

            if place_meeting_round(x+block.dx,y,block)
            {
                block.x -= block.dx
                var _place_fix;
                if block.dy > 0
                {
                    _place_fix = physics_fix(x,y,270,1,block.dy)
                    physics_moving_B = true
                }
                else
                {
                    _place_fix = physics_fix(x,y,90,1,0-block.dy)
                    physics_moving_T = true
                }
                if !_place_fix
                    solid_crush = true
                block.x += block.dx
            }
        }

        instance_ignore(block)
    }
}
until( !block )
instance_recover()

//platform_moving fix
if gravity_place && gravity_state != -1
{
    var block;
    do
    {
        block = instance_place_round(x,y,o_platform_moving)
        if block
        {
            if ( block.type = 0 || phy_type = block.type ) && ( block.dx != 0 || block.dy != 0 )
            {
                var _pd;
                _pd = min(0, block.dx*cosd(gravity_dir) - block.dy*sind(gravity_dir) )
                if gravity_v >= _pd
                {
                    var _px, py;
                    _px = x - _pd*cosd(gravity_dir) + cosd(gravity_dir)
                    _py = y + _pd*sind(gravity_dir) - sind(gravity_dir)

                    if !place_meeting_round(x+block.dx,y+block.dy,block) && place_meeting_round(_px+block.dx,_py+block.dy,block)
                    {
                        gravity_state = 0
                        gravity_v = 0

                        do
                        {
                            _px -= cosd(gravity_dir)
                            _py += sind(gravity_dir)
                        }
                        until ( !place_meeting_round(_px+block.dx,_py+block.dy,block) )

                        gravity_fix_vx += block.dx + (_px-x) - gravity_fix_vx
                        gravity_fix_vy += block.dy + (_py-y) - gravity_fix_vy

                    }
                }
            }

            instance_ignore(block)
        }
    }
    until( !block )
    instance_recover()
}
