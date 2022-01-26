#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()

sprite_index = s_lava
image_speed = 0.1

lava = instance_create(x,y,o_lava_backdrop)

velocity = 2
ytarget = y
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
while ( x < view_xview[0] - 32 )
    x += 32
while ( x > view_xview[0] )
    x -= 32

if !global.pause
{
    if y >= ytarget + velocity
        y -= velocity
    else if y <= ytarget - velocity
        y += velocity
    else
        y = ytarget
}

lava.y = y
with(lava)
{
    visible = false
    x = o_camera.L
    image_xscale = ( o_camera.R - x + 96 )/32.0
    image_yscale = ( o_camera.B - y + 96 )/32.0
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var i;
i = 0
while ( x+i*32 < view_xview[0] + view_wview[0] )
{
    draw_sprite_ext(s_lava, image_index, x+i*32, y, 1, 1, 0, c_white, image_alpha)
    i += 1
}
draw_sprite_ext(s_lava_backdrop, 0, view_xview[0], max(view_yview[0], y+32), view_wview[0]/32.0, min(view_hview[0],view_yview[0]+view_hview[0]-y-32)/32.0, 0, c_white, image_alpha)
