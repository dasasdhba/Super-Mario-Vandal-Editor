#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
pause = -1

interval = 300
number = 10
dir = -1
cheep = 0 // =0: red, =1: green

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
        fish = o_cheep_red
    else
        fish = o_cheep_green

    if instance_number(fish) < number
        count += 1
    if count >= interval
    {
        count = 0
        var c,cx,cy;
        if dir = -1
            cx = view_xview[0] + view_wview[0] + 32
        else
            cx = view_xview[0] - 32
        cy = y + 32 + irandom(abs(bbox_bottom-bbox_top)-32)
        c = instance_create(cx,cy,fish)
        c.dir = dir
        c.activate = true
    }
}
