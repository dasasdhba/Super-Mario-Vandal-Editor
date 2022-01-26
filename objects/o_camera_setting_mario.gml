#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
pause = -1

//current region border
L = ""
R = ""
T = ""
B = ""

//let Mario not run out of frame
screen_limit = ""

//target screen
scale = ""
scale_v = "" //the speed of scale changing

//target offset
xoffset = ""
yoffset = ""

//whether to target Mario
target_mario = ""

mode = ""
/*
mode = 0: follow
mode = 1: self moving
mode = 2: switch
*/

//the speed of follow mode
follow_vx = ""
follow_vy = ""

//gradually switch the border
gradual = ""
gradual_vx = ""
gradual_vy = ""
gradual_xmin = ""
gradual_xmax = ""
gradual_ymin = ""
gradual_ymax = ""

//self moving mode
move_v = ""
move_dir = ""
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    if instance_number(o_camera) > 0 && place_meeting(x,y,o_mario)
    {
        if !once
        {
            once = true
            if(is_real(L)) o_camera.L = L
            if(is_real(R)) o_camera.R = R
            if(is_real(T)) o_camera.T = T
            if(is_real(B)) o_camera.B = B
            if(is_real(screen_limit)) o_camera.screen_limit = screen_limit
            if(is_real(scale)) o_camera.scale_target = scale
            if(is_real(scale_v)) o_camera.scale_v = scale_v
            if(is_real(xoffset)) o_camera.xoffset = xoffset
            if(is_real(yoffset)) o_camera.yoffset = yoffset
            if(is_real(target_mario)) o_camera.target_mario = target_mario
            if(is_real(mode)) o_camera.mode = mode
            if(is_real(follow_vx)) o_camera.follow_vx = follow_vx
            if(is_real(follow_vy)) o_camera.follow_vy = follow_vy
            if(is_real(move_v)) o_camera.move_v = move_v
            if(is_real(move_dir)) o_camera.move_dir = move_dir
            if(is_real(gradual_vx)) o_camera.gradual_vx = gradual_vx
            if(is_real(gradual_vy)) o_camera.gradual_vy = gradual_vy
            if(is_real(gradual_xmin)) o_camera.gradual_xmin = gradual_xmin
            if(is_real(gradual_xmax)) o_camera.gradual_xmax = gradual_xmax
            if(is_real(gradual_ymin)) o_camera.gradual_ymin = gradual_ymin
            if(is_real(gradual_ymax)) o_camera.gradual_ymax = gradual_ymax
            if(is_real(gradual))
            {
                o_camera.gradual_x = gradual
                o_camera.gradual_y = gradual
            }
        }
    }
    else
        once = false
}
