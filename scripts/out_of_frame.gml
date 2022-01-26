//out_of_frame(range)
var _range, _left, _right, _top, _bottom;
if argument_count = 1
    _range = argument0
else
    _range = 0

_left = min(bbox_left,bbox_right)
_right = max(bbox_right,bbox_left)
_top = min(bbox_top,bbox_bottom)
_bottom = max(bbox_bottom,bbox_top)

if _right < view_xview[0] - _range || _left > view_xview[0] + view_wview[0] + _range
|| _bottom < view_yview[0] - _range || _top > view_yview[0] + view_hview[0] + _range
    return true;

return false;
