//physics_init()
//init for physics

physics = true
var i, phy_exist;
phy_exist = false
for(i=0;i<ds_list_size(global.physics_object);i+=1)
{
    if ds_list_find_value(global.physics_object, i) = object_index
        phy_exist = true
}
if !phy_exist
    ds_list_add(global.physics_object,object_index)

phy_type = 0
phy_slope = 5

//water detect
water_in = false
water_in_flag = false
water_out = false
water_out_flag = true
var place_obj;
place_obj = instance_place_round(x,y,o_water)
if place_obj && ( place_obj.type = 0 || place_obj.type = phy_type )
{
    water_in_flag = true
    water_out_flag = false
}

//gravity
gravity_state = 0 // 0 = onFloor; 1 = offFloor
gravity_water = false
gravity_place = true
gravity_dir = 270
gravity_v = 0 //velocity
gravity_max = 10 //max velocity
gravity_max_water = 3 //max velocity in water
gravity_a = 1 //acceleration
gravity_d = 1 //deceleration
gravity_a_water = 0.1 //acceleration in water
gravity_d_water = 0.85 //deceleration in water

gravity_hit_up = false
gravity_hit_down = false

//move
move_state = 0 // 0 = static; 1 = moving
move_place = true
move_dir = 0
move_v = 0 //velocity
move_mode = 0 // if move_hit { 0 = stop; 1 = turn; 2 = move_hit_ext }

move_hit = false
move_hit_ext = false //not automatically be set to false

//auto
auto_place = false
auto_finish = false

//crush detect
solid_crush = false

//moving solid/platform fix
physics_moving_T = false
physics_moving_D = false
physics_moving_L = false
physics_moving_R = false
gravity_fix_vx = 0 //x velocity of moving platform
gravity_fix_vy = 0 //y velocity of moving platform
