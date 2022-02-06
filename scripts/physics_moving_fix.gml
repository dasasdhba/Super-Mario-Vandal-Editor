//physics_moving_fix()

//solid_moving fix
var _pL,_pR,_pT,_pB,_ox,_oy;
_pL = false
_pR = false
_pT = false
_pB = false
_ox = x
_oy = y

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
                block.y -= dy
                var _place_fix;
                if block.dx > 0
                {
                    _place_fix = physics_fix(x,y,0,1,block.dx)
                    _pR = true
                }
                else
                {
                    _place_fix = physics_fix(x,y,180,1,0-block.dx)
                    _pL = true
                }
                if !_place_fix
                    solid_crush = true
                block.y += dy
            }

            if place_meeting_round(x+block.dx,y,block)
            {
                block.x -= dx
                var _place_fix;
                if block.dy > 0
                {
                    _place_fix = physics_fix(x,y,270,1,block.dy)
                    _pB = true
                }
                else
                {
                    _place_fix = physics_fix(x,y,90,1,0-block.dy)
                    _pT = true
                }
                if !_place_fix
                    solid_crush = true
                block.x += dx
            }
        }

        instance_ignore(block)
    }
}
until( !block )
instance_recover(o_solid_moving)

if gravity_place && gravity_state = 0
{
    with(o_solid_moving)
    {
        x -= dx
        y -= dy
    }

    var block;
    do
    {
        block = instance_place_round(_ox+cosd(gravity_dir),_oy-sind(gravity_dir),o_solid_moving)
        if block
        {
            if block.type = 0 || block.type = phy_type
            {
                if ( block.dx != 0 || block.dy != 0 ) && !place_meeting_round(_ox,_oy,block)
                {
                    if ( block.dx > 0 && !_pR ) || ( block.dx < 0 && !_pL )
                        gravity_fix_vx += block.dx - gravity_fix_vx
                    if ( block.dy > 0 && !_pB ) || ( block.dy < 0 && !_pT )
                        gravity_fix_vy += block.dy - gravity_fix_vy
                }
            }

            instance_ignore(block)
        }
    }
    until( !block )
    instance_recover(o_solid_moving)

    with(o_solid_moving)
    {
        x += dx
        y += dy
    }

}

//platform_moving fix
if gravity_place && gravity_state != -1
{
    var block;
    do
    {
        block = instance_place_round(x+cosd(gravity_dir),y-sind(gravity_dir),o_platform_moving)
        if !block
        {
            with(o_platform_moving)
            {
                x -= dx
                y -= dy
            }

            block = instance_place_round(x+cosd(gravity_dir),y-sind(gravity_dir),o_platform_moving)

            with(o_platform_moving)
            {
                x += dx
                y += dy
            }
        }
        if block
        {
            if ( block.type = 0 || phy_type = block.type ) && ( block.dx != 0 || block.dy != 0 )
            {
                var _pd;
                _pd = min(0, block.dx*cosd(gravity_dir) - block.dy*sind(gravity_dir) )
                if gravity_v >= _pd
                {
                    var _px,py;
                    _px = x - _pd*cosd(gravity_dir) + cosd(gravity_dir)
                    _py = y + _pd*sind(gravity_dir) - sind(gravity_dir)
                    block.x -= block.dx
                    block.y -= block.dy
                    if !place_meeting_round(x,y,block) && place_meeting_round(_px,_py,block)
                    {
                        gravity_state = 0
                        gravity_v = 0

                        _px -= cosd(gravity_dir)
                        _py += sind(gravity_dir)
                        while ( place_meeting_round(_px,_py,block) )
                        {
                            _px -= cosd(gravity_dir)
                            _py += sind(gravity_dir)
                        }

                        if block.dx != 0
                            gravity_fix_vx += block.dx + (_px-x) - gravity_fix_vx
                        if block.dy != 0
                            gravity_fix_vy += block.dy + (_py-y) - gravity_fix_vy
                    }
                    block.x += block.dx
                    block.y += block.dy
                }
            }

            instance_ignore(o_platform_moving)
        }
    }
    until( !block )
    instance_recover(o_platform_moving)
}

//stand position fix
if gravity_fix_vx != 0
{
    x += gravity_fix_vx
    if physics_place(x,y,1)
    {
        if gravity_fix_vx > 0
            physics_fix(x,y,180,1)
        else
            physics_fix(x,y,0,1)
    }
}
if gravity_fix_vy != 0
{
    y += gravity_fix_vy
    if physics_place(x,y,1)
    {
        if gravity_fix_vy > 0
            physics_fix(x,y,90,1)
        else
            physics_fix(x,y,270,1)
    }
}
gravity_fix_vx = 0
gravity_fix_vy = 0
