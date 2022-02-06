#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
pause = -1

ID = 0

once = false
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    if !once
    {
        once = true
        event_user(0)
    }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
L = x
T = y
globalvar _self;
_self = id
with(o_camera_end)
{
    if ID = _self.ID
    {
        _self.R = x + 32
        _self.B = y + 32
    }
}

if o_mario.bbox_right >= L && o_mario.bbox_left <= R && o_mario.bbox_bottom >= T && o_mario.bbox_top <= B
{
    o_camera.L = L
    o_camera.R = R
    o_camera.T = T
    o_camera.B = B

    with(o_music)
    {
        if x = _self.x + 32 && y = _self.y && view = 1
            view = 2
    }

    with(o_background)
    {
        if x = _self.x + 32 && y = _self.y && view = 1
            view = 2
    }

    with(o_water_height_instant)
    {
        if x = _self.x + 32 && y = _self.y && view = 1
            view = 2
    }

    with(o_lava_height_instant)
    {
        if x = _self.x + 32 && y = _self.y && view = 1
            view = 2
    }
}
