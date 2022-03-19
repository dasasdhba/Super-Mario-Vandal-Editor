#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()

type = 0
swim = true

sprite_index = s_water_surface
image_alpha = 0.4
image_speed = 0.3

water = instance_create(x,y,o_water)

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

water.y = y
with(water)
{
    visible = false
    type = type
    swim = swim
    x = o_camera.L
    image_xscale = ( max(0, o_camera.R - x) + 96 )/32.0
    image_yscale = ( max(0, o_camera.B - y) + 96 )/32.0
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
    draw_sprite_ext(s_water_surface, image_index, x+i*32, y, 1, 1, 0, c_white, image_alpha)
    i += 1
}
draw_sprite_ext(s_water, 0, view_xview[0], max(view_yview[0], y+32), view_wview[0]/32.0, min(view_hview[0],view_yview[0]+view_hview[0]-y-32)/32.0, 0, c_white, image_alpha)
