#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
pause = -1

ID = 0
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause && o_mario.pipe = 5 && place_meeting(x,y,o_mario)
{
    globalvar _ID;
    _ID = ID
    with (o_pipe_warp_end)
    {
        if ID = _ID
        {
            o_mario.x = x
            o_mario.y = y
            with(o_camera_start)
                event_user(0)
            with(o_camera_auto)
            {
                if activate = true
                {
                    activate = false
                    o_camera.mode = 0
                }
                event_user(0)
            }
        }
    }
}
