#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
pause = -1

var _angle;
_angle = image_angle
while ( _angle < 0 )
    _angle += 360

_angle = _angle mod 360

if _angle = 0
{
    L = bbox_left + 1
    R = bbox_right
    T = bbox_top + 1
    B = bbox_bottom
}
else if _angle = 90
{
    L = bbox_left + 1
    R = bbox_right
    T = bbox_top
    B = bbox_bottom - 1
}
else if _angle = 180
{
    L = bbox_left
    R = bbox_right - 1
    T = bbox_top
    B = bbox_bottom - 1
}
else if _angle = 270
{
    L = bbox_left
    R = bbox_right - 1
    T = bbox_top + 1
    B = bbox_bottom
}
