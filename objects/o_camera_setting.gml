#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
pause = -1

once = false

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
    var camera;
    camera = instance_place(x,y,o_camera)
    if camera
    {
        if !once
        {
            once = true
            if(is_real(L)) camera.L = L
            if(is_real(R)) camera.R = R
            if(is_real(T)) camera.T = T
            if(is_real(B)) camera.B = B
            if(is_real(screen_limit)) camera.screen_limit = screen_limit
            if(is_real(scale)) camera.scale_target = scale
            if(is_real(scale_v)) camera.scale_v = scale_v
            if(is_real(xoffset)) camera.xoffset = xoffset
            if(is_real(yoffset)) camera.yoffset = yoffset
            if(is_real(target_mario)) camera.target_mario = target_mario
            if(is_real(mode)) camera.mode = mode
            if(is_real(follow_vx)) camera.follow_vx = follow_vx
            if(is_real(follow_vy)) camera.follow_vy = follow_vy
            if(is_real(move_v)) camera.move_v = move_v
            if(is_real(move_dir)) camera.move_dir = move_dir
            if(is_real(gradual_vx)) camera.gradual_vx = gradual_vx
            if(is_real(gradual_vy)) camera.gradual_vy = gradual_vy
            if(is_real(gradual_xmin)) camera.gradual_xmin = gradual_xmin
            if(is_real(gradual_xmax)) camera.gradual_xmax = gradual_xmax
            if(is_real(gradual_ymin)) camera.gradual_ymin = gradual_ymin
            if(is_real(gradual_ymax)) camera.gradual_ymax = gradual_ymax
            if(is_real(gradual))
            {
                camera.gradual_x = gradual
                camera.gradual_y = gradual
            }
        }

    }
    else
        once = false
}
