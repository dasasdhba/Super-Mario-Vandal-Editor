#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
pause = -1

moving_state = ""
moving_v = ""
moving_a = ""
stand_check = ""
fall_check = ""
reverse_turn = ""
direction_turn = ""
reverse = ""

once = true
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    var moving;
    moving = instance_place(x,y,o_solid_moving)
    if !moving
        moving = instance_place(x,y,o_platform_moving)

    if moving
    {
        if is_real(moving_state) moving.moving_state = moving_state
        if is_real(moving_v) moving.moving_v = moving_v
        if is_real(moving_a) moving.moving_a = moving_a
        if is_real(stand_check) moving.stand_check = stand_check
        if is_real(fall_check) moving.fall_check = fall_check
        if is_real(reverse_turn) moving.reverse_turn = reverse_turn
        if is_real(direction_turn) moving.direction_turn = direction_turn
        if is_real(reverse) moving.reverse = reverse
        if once
            instance_destroy()
    }

}
