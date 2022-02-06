//moving_step()
//step event for moving block

//detect setting
if !moving_detect
{
    moving_detect = true
    var _detect;

    _detect = instance_place(x,y,o_moving_reverse)
    if _detect
    {
        reverse = 1 - reverse
        with(_detect)
        {
            instance_destroy()
        }
    }

    if !reverse
    {
        _detect = instance_place(x,y,o_moving_turn)
        if _detect
        {
            move_dir = _detect.image_angle
            if moving_v = 0
                moving_v = velocity
            with(_detect)
            {
                instance_destroy()
            }
        }
    }
    else
    {
        _detect = instance_place(x,y,o_reverse_turn)
        if _detect
        {
            move_dir = _detect.image_angle
            if moving_v = 0
                moving_v = velocity
            with(_detect)
            {
                instance_destroy()
            }
        }
    }

    _detect = instance_place(x,y,o_moving_stand)
    if _detect
    {
        stand_check = 1
        with(_detect)
        {
            instance_destroy()
        }
    }

    _detect = instance_place(x,y,o_moving_fall)
    if _detect
    {
        fall_check = 1
        with(_detect)
        {
            instance_destroy()
        }
    }

}

//stand_check
if moving_state = 0
{
    if stand_check = 0
    || ( stand_check = 1 && o_mario.gravity_state = 0 && place_meeting_round(x-cosd(o_mario.gravity_dir), y+sind(o_mario.gravity_dir), o_mario) )
    {
        moving_state = 1
        move_v = moving_v
        stand_check = 2
    }

}

if moving_state = 1 && move_v > 0
{

    //teleport
    var _detect;
    _detect = instance_place_round(x,y,o_moving_teleport)
    if _detect
    {
        x += _detect.xoffset
        y += _detect.yoffset
        xorigin = round(x)
        yorigin = round(y)

        with(_detect)
        {
            if once
                instance_destroy()
        }
    }

    //gradual turning
    if turn_state = 0 && ( reverse_turn = 2 || direction_turn = 2 )
    {
        if turn_calc != moving_v
        {
            var _dv;
            turn_calc = moving_v
            _dv = turn_calc div moving_a
            turn_distance = turn_calc*_dv - moving_a*_dv*(_dv+1)/2
        }

        var _detect,_dx,_dy;
        _dx = x + turn_distance*cosd(move_dir)
        _dy = y - turn_distance*sind(move_dir)

        if reverse_turn = 2
        {
            _detect = instance_place_round(_dx,_dy,o_moving_reverse)
            if _detect
            {
                turn_state = 1
                turn_v = move_v
                turn_dir = ""
            }

        }

        if direction_turn = 2
        {
            if !reverse
                _detect = instance_place_round(_dx,_dy,o_moving_turn)
            else
                _detect = instance_place_round(_dx,_dy,o_reverse_turn)
            if _detect && _detect.image_angle != move_dir
            {
                var _cx,_tx,_cy,_ty;
                _cx = (bbox_left + bbox_right)/2
                _tx = (_detect.bbox_left + _detect.bbox_right)/2
                _cy = (bbox_top + bbox_bottom)/2
                _ty = (_detect.bbox_top + _detect.bbox_bottom)/2
                if ( _cx < _tx && _cx + (_dx-x) >= _tx ) || ( _cx > _tx && _cx + (_dx-x) <= _tx )
                || ( _cy < _ty && _cy + (_dy-y) >= _ty ) || ( _cy > _ty && _cy + (_dy-y) <= _ty )
                {
                    turn_state = 1
                    turn_v = move_v
                    turn_dir = _detect.image_angle
                }
            }

        }

    }

    if turn_state = 1
    {
        if move_v > 0
            move_v -= moving_a
        if move_v <= 0
        {
            if is_real(turn_dir)
            {
                move_v = 0
                move_dir = turn_dir
                turn_state = 2
            }
            else
                move_v = moving_a
        }
    }

    if turn_state = 2
    {
        if turn_v = 0
            turn_v = moving_v

        if move_v < turn_v
            move_v += moving_a
        if move_v >= turn_v
        {
            move_v = turn_v
            turn_state = 0
        }
    }

}

//fall_check
if moving_state < 2
{
    var _detect;
    _detect = instance_place(x,y,o_moving_fall)
    if _detect || ( fall_check = 1 && o_mario.gravity_state = 0 && place_meeting_round(x-cosd(o_mario.gravity_dir), y+sind(o_mario.gravity_dir), o_mario) )
    {
        moving_state = 2
        gravity_state = 1
        gravity_v = move_v*sind(gravity_dir - move_dir + 90)
        move_v *= cosd(gravity_dir - move_dir + 90)
        move_dir += gravity_dir - move_dir + 90

        if _detect && _detect.once
            with(_detect)
            {
                instance_destroy()
            }

    }
}

//fall recover check
if moving_state = 2
{
    var _detect;
    _detect = instance_place(x,y,o_moving_fall_recover)
    if _detect
    {
        fall_check = 0
        moving_state = 1
        gravity_state = -1
        gravity_v = 0
        with(_detect)
        {
            if _detect.once
                instance_destroy()
        }

    }

    var f_height;
    f_height = sprite_height + 64
    if ( ( gravity_dir >= 225 && gravity_dir <= 315 ) && y >= room_height + f_height )
    || ( ( gravity_dir >= 45 && gravity_dir <= 135 ) && y <= 0 - f_height )
    || ( ( gravity_dir >= 135 && gravity_dir <= 225 ) && x <= 0 - f_height )
    || ( ( gravity_dir >= 315 || gravity_dir <= 45 ) && x >= room_width + f_height )
        instance_destroy()
}
