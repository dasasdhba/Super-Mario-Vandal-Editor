#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//this user event should be called in Create Event
if !variable_local_exists("bonus_place")
    bonus_place = false // whether the bunus is placed in block
bonus_rise = true // rise automatically if in the solid
bonus_rise_v = 1

mushroom = false // if this is true, the bonus in the block will become mushroom when Mario is small
