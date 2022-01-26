#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()

dir = 90
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    image_alpha -= 0.01
    if image_alpha = 0
        instance_destroy()

    if place_meeting(x, y, o_water)
    {
        image_index = 0
        image_speed = 0

        //movement
        var vx,vy;
        vx = irandom_range(-1,1)
        vy = irandom(2)

        x += vx*cosd(dir+90) + vy*cosd(dir)
        y -= vx*sind(dir+90) + vy*sind(dir)

    }
    else
    {
        image_speed = 1
        if image_index >= 8
            instance_destroy()
    }

}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !out_of_frame()
    draw_self()
