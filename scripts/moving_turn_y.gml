//moving_turn_y()

//reverse
if reverse_turn >= 0 && reverse_turn <= 2
{
    var _detect;
    _detect = instance_place_round(x,y,o_moving_reverse)

    if _detect
    {
        reverse = 1 - reverse

        var _ds;
        _ds = sign(sind(move_dir))
        do
        {
            y += _ds
        }
        until ( !place_meeting_round(x,y,_detect) )

        if reverse_turn = 0
        {
            moving_state = 0
            move_v = moving_a
        }
        else
        {
            if _detect.reverse
                move_dir += 180
            else
                move_dir = 0 - move_dir

            if reverse_turn = 2
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
        var _cy,_ty;
        _cy = (bbox_top + bbox_bottom)/2
        _ty = (_detect.bbox_top + _detect.bbox_bottom)/2
        if ( _cy < _ty && _cy + (_dy-y) >= _ty ) || ( _cy > _ty && _cy + (_dy-y) <= _ty )
        {
            y = _ty - ( _cy - y )
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
