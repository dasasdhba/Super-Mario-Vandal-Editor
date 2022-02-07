//moving_motion()
if move_v > 0
{
    var _dx, _dy;
    _dx = move_v*cosd(move_dir)
    _dy = move_v*sind(move_dir)

    if _dx != 0
    {
        x += _dx
        moving_turn_x()
    }
    if _dy != 0
    {
        y -= _dy
        moving_turn_y()
    }

    if solid_turn >= 0 && ( _dx != 0 || _dy != 0 )
    {
        phy_type = 0
        if physics_place(x,y,1)
        {
            physics_fix(x,y,move_dir+180,1)
            if solid_turn = 0
            {
                moving_state = 0
                move_v = 0
            }
            else if solid_turn = 1
            {
                move_dir += 180
                if turn_state = 1
                    turn_state = 2
            }
        }
    }
}
if gravity_state = 1
{
    if gravity_v < gravity_max
        gravity_v += gravity_a
    if gravity_v > gravity_max
        gravity_v -= gravity_d

    x += gravity_v*cosd(gravity_dir)
    y -= gravity_v*sind(gravity_dir)
}
