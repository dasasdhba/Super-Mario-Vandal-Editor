#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
pause = -1

//current region border
L = 0
R = room_width
T = 0
B = room_height
scale = 1

//let Mario not run out of frame
screen_limit = true

//target position
xtarget = 0
ytarget = 0

//target offset
xoffset = 0
yoffset = 0

scale_target = 1 //target scale
scale_v = 0.1 //the speed of scale changing

//whether to target Mario
target_mario = true

mode = 0
/*
mode = 0: follow
mode = 1: self moving
mode = 2: switch
*/

//the speed of follow mode
follow_vx = 0
follow_vy = 0

//gradually change the border
gradual_x = false
gradual_y = false
gradual_vx = 0.1
gradual_vy = 0.1
gradual_xmin = 2
gradual_xmax = 10
gradual_ymin = 3
gradual_ymax = 15

//self moving mode
move_v = 0
move_dir = 0

shake_range = 16
shake = 0 //the time of shaking
/*
>0: the screen will shake within the border
<0: the screen will shake without the border
*/
