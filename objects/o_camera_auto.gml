#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
pause = -1
sprite_fix_offset(16,16)

velocity = 1
ID = 0

first = false
next = noone
once = false
activate = false
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
//first activate
var L, T, R, B;
L = x - view_wview[0]/2
T = y - view_hview[0]/2
R = x + view_wview[0]/2
B = y + view_hview[0]/2
if o_mario.bbox_right >= L && o_mario.bbox_left <= R && o_mario.bbox_bottom >= T && o_mario.bbox_top <= B
    first = true
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//find next
globalvar _self, _last;
_self = id
_last = true
with(o_camera_auto)
{
    if ID = _self.ID + 1
    {
        o_camera.x = _self.x
        o_camera.y = _self.y
        o_camera.mode = 1
        o_camera.move_v = _self.velocity
        o_camera.move_dir = point_direction(_self.x, _self.y, x, y)
        _self.next = id
        _last = false
    }
}

if _last
{
    o_camera.x = x
    o_camera.y = y
    o_camera.mode = 1
    o_camera.move_v = 0
    next = noone
}
