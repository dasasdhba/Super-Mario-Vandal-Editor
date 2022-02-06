//moving_turn_x()

//reverse
if reverse_turn >= 0 && reverse_turn <= 2
{
    var _detect;
    _detect = instance_place_round(x,y,o_moving_reverse)

    if _detect
    {
        reverse = 1 - reverse

        var _ds;
        _ds = sign(cosd(move_dir))
        do
        {
            x -= _ds
        }
        until ( !place_meeting_round(x,y,_detect) )

        if reverse_turn = 0
        {
            moving_state = 0
            move_v = 0
        }
        else
        {
            if _detect.reverse
                move_dir += 180
            else
                move_dir = 180 - move_dir

            if reverse_turn = 2
            {
                turn_state = 2
                move_v = moving_a
            }
        }

        with(_detect)
        {
            if once
                instance_destroy()
        }

    }
}

//direction
if direction_turn >= 0 && direction_turn <= 2
{
    var _detect;
    if !reverse
        _detect = instance_place_round(x,y,o_moving_turn)
    else
        _detect = instance_place_round(x,y,o_reverse_turn)

    if _detect && _detect.image_angle != move_dir
    {
        var _cx,_tx;
        _cx = (bbox_left + bbox_right)/2
        _tx = (_detect.bbox_left + _detect.bbox_right)/2
        if ( _cx < _tx && _cx + (_dx-x) >= _tx ) || ( _cx > _tx && _cx + (_dx-x) <= _tx )
        {
            x = _tx - ( _cx - x )
            if direction_turn = 0
            {
                moving_state = 0
                move_v = 0
            }
            else
            {
                move_dir = _detect.image_angle
                if direction_turn = 2
                {
                    turn_state = 2
                    move_v = 0
                }
            }

            with(_detect)
            {
                if once
                    instance_destroy()
            }
        }
    }

}
