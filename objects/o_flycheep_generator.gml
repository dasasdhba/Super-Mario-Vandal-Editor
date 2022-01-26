#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
pause = -1

interval = 13
number = 3
dir = -1
range = 300
vx = 2
vx_random = 3
vy = 7
vy_random = 7
cheep = 0 // =0: red, =1: blue

count = 0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause && place_meeting(x,y,o_mario)
{
    var fish;
    if cheep = 0
        fish = o_flycheep_red
    else
        fish = o_flycheep_blue

    if instance_number(fish) < number
        count += 1
    if count >= interval
    {
        count = 0
        var c,cx,cy;
        if dir = -1
            cx = view_xview[0] + view_wview[0]/2 + 32 + irandom(view_wview[0]/2)
        else
            cx = view_xview[0] - 32 + irandom(view_wview[0]/2)
        cy = bbox_get_bottom() + irandom(range)
        c = instance_create(cx,cy,fish)
        if dir = 1
            c.move_dir = 0
        else
            c.move_dir = 180
        c.move_v = vx + irandom(vx_random)
        c.gravity_v = 0 - vy - irandom(vy_random)

    }
}
