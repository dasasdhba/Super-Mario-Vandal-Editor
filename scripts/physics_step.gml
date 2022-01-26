//physics_step()
//physics main progress in step event

//fix move_v
if move_v < 0
{
    move_v *= -1
    move_dir += 180
}

//gravity

//water check
gravity_water = false
var place_obj;
place_obj = instance_place_round(x,y,o_water)
if place_obj && ( place_obj.type = 0 || place_obj.type = phy_type )
{
    gravity_water = true

    if water_in_flag = false
    {
        water_in = true
        water_in_flag = true
    }

    if water_out_flag = true
    {
        water_out = false
        water_out_flag = false
    }
}
else
{
    if water_out_flag = false
    {
        water_out = true
        water_out_flag = true
    }

    if water_in_flag = true
    {
        water_in = false
        water_in_flag = false
    }
}

//floor check
if gravity_state = 0
{
    if gravity_place
    {
        if gravity_v > 0
            gravity_v = 0

        if gravity_v < 0
            gravity_state = 1
        else if !physics_place(x+cosd(gravity_dir),y-sind(gravity_dir),0,1)
        {
            gravity_state = 1
            if phy_slope > 0 && move_state = 1
            {
                var place_slope_x, place_slope_y;
                place_slope_x = x+(phy_slope+ceil(move_v))*cosd(gravity_dir)
                place_slope_y = y-(phy_slope+ceil(move_v))*sind(gravity_dir)
                if physics_place(place_slope_x,place_slope_y,0,phy_slope+ceil(move_v))
                {
                    physics_fix(place_slope_x,place_slope_y,gravity_dir+180,0,phy_slope+ceil(move_v))
                    gravity_state = 0
                }
            }
        }
    }
    else
    {
        if gravity_v != 0
            gravity_state = 1
    }

}

if gravity_state = 1
{
    if gravity_water
    {
        if gravity_v < gravity_max_water
            gravity_v += gravity_a_water
        if gravity_v > gravity_max_water
            gravity_v -= gravity_d_water
    }
    else
    {
        if gravity_v < gravity_max
            gravity_v += gravity_a
        if gravity_v > gravity_max
            gravity_v -= gravity_d
    }

    x += gravity_v*cosd(gravity_dir)
    y -= gravity_v*sind(gravity_dir)

    if gravity_place
    {
        if gravity_v < 0 && physics_place(x,y,1)
        {
            physics_fix(x,y,gravity_dir,1)
            gravity_v = 0
            gravity_hit_up = true
        }
        if gravity_v > 0 && physics_place(x,y,0,ceil(gravity_v))
        {
            physics_fix(x,y,gravity_dir+180,0,ceil(gravity_v))
            gravity_v = 0
            gravity_state = 0
            gravity_hit_down = true
        }
    }
}

//move
if move_state = 0 && move_v != 0
    move_state = 1

if move_state = 1
{
    x += move_v*cosd(move_dir)
    y -= move_v*sind(move_dir)

    if move_place && move_v > 0 && physics_place(x,y,1)
    {
        var place_check;
        place_check = true
        if phy_slope > 0 && gravity_place && ( gravity_state = 0 || ( gravity_state = 1 && gravity_v >= 0 ) )
        {
            var place_slope_x, place_slope_y;
            place_slope_x = x-(phy_slope+ceil(move_v))*cosd(gravity_dir)
            place_slope_y = y+(phy_slope+ceil(move_v))*sind(gravity_dir)
            place_check = physics_place(place_slope_x,place_slope_y,0,phy_slope+ceil(move_v))
            if !place_check
                physics_fix(x,y,gravity_dir+180,0,phy_slope+ceil(move_v))
        }

        if place_check
        {
            physics_fix(x,y,move_dir+180,1)
            move_hit = true
            switch (move_mode)
            {
                case 0: move_v = 0; break;
                case 1: move_dir += 180; break;
                case 2: move_hit_ext = true; break;
                default: break;
            }
        }
    }
}

//auto
if auto_place
{
    var auto_count, place_check;
    auto_count = 0
    place_check = physics_place(x,y,1)
    while ( place_check )
    {
        auto_count += 1
        if !physics_place(x-auto_count,y,1)
        {
            x -= auto_count
            auto_finish = true
            break;
        }
        if !physics_place(x+auto_count,y,1)
        {
            x += auto_count
            auto_finish = true
            break;
        }
        if !physics_place(x,y-auto_count,1)
        {
            y -= auto_count
            auto_finish = true
            break;
        }
        if !physics_place(x,y+auto_count,1)
        {
            y += auto_count
            auto_finish = true
            break;
        }
    }
}

//fix the direction value
while ( gravity_dir < 0 )
    gravity_dir += 360
while ( move_dir < 0 )
    move_dir += 360

gravity_dir = gravity_dir mod 360
move_dir = move_dir mod 360
