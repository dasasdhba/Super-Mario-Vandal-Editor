#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_user(0)
turn = false
def_stomp = -1
def_bump = -1

sprite_fix_offset(16,31)
image_speed = 0.2

instance_init()

xspeed = 3
yspeed = 0.8
float_time = 25

dir = -1
float = 0
count = 0

scores = 100
activate = false

refresh = false
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    if !activate
    {
        if !out_of_frame(64)
        {
            activate = true
            if abs(cosd(image_angle)) >= abs(sind(image_angle))
            {
                if x*sign(cosd(image_angle)) <= o_mario.x*sign(cosd(image_angle))
                    dir = 1
                else
                    dir = -1
            }
            else
            {
                if y*sign(sind(image_angle)) <= o_mario.y*sign(sind(image_angle))
                    dir = 1
                else
                    dir = -1
            }
        }
    }
    else
    {
        var dx,dy;
        dx = xspeed * dir
        dy = yspeed * float
        x += dx*cosd(image_angle) + dy*sind(image_angle)
        y -= dx*sind(image_angle) - dy*cosd(image_angle)

        count += 1
        if count >= float_time
        {
            count = 0
            float = irandom(2) - 1
        }

        //water_detect
        if !place_meeting(x-16*sind(image_angle), y-16*cosd(image_angle) ,o_water)
            float = 1

        //attacked
        event_user(1)

        if atk > 0
        {
            if atk < 5
            {
                var s;
                s = instance_create((bbox_left+bbox_right)/2, min(bbox_top,bbox_bottom), o_score)
                s.scores = scores
            }

            var death;
            death = instance_create(x, y, o_enemy_death)
            death.sprite_index = sprite_index
            death.image_angle = image_angle
            death.image_xscale = dir*image_xscale
            death.image_yscale = image_yscale
            death.yflip = true
            death.gravity_dir = image_angle + 270

            if atk != 5 && atk != 6
                audio_sound_play("kick_1")

            instance_destroy()
        }

        //out_of_border
        if ( dir*sign(cosd(image_angle)) = 1 && x >= room_width + 32*abs(image_xscale) ) || ( dir*sign(cosd(image_angle)) = -1 && x <= -32*abs(image_xscale) )
        || ( dir*sign(sind(image_angle)) = 1 && y <= -32*abs(image_xscale) ) || ( dir*sign(sind(image_angle)) = -1 && y >= room_height + 32*abs(image_xscale) )
            instance_destroy()

        //refresh
        if refresh
        {
            if ( dir*sign(cosd(image_angle)) = 1 && x >= view_xview[0] + view_wview[0] + 96*abs(image_xscale) ) || ( dir*sign(cosd(image_angle)) = -1 && x <= view_xview[0] - 96*abs(image_xscale) )
            || ( dir*sign(sind(image_angle)) = 1 && y <= view_yview[0] - 96*abs(image_xscale) ) || ( dir*sign(sind(image_angle)) = -1 && y >= view_yview[0] + view_hview[0] + 96*abs(image_xscale) )
                instance_destroy()
        }

    }

}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !out_of_frame()
    draw_self_scale(dir*image_xscale,image_yscale)
