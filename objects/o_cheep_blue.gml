#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_user(0)
shell = 1
def_stomp = -1
def_fireball = 0
def_beet = 0
def_bump = -1

sprite_fix_offset(16,31)
image_speed = 0.1

instance_init()
physics_init()
phy_type = 2
gravity_state = -1
gravity_place = false
gravity_dir = image_angle+270
move_mode = 1

velocity = 1

dir = -1

scores = 500
activate = false
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
            if abs(sind(gravity_dir)) >= abs(cosd(gravity_dir))
            {
                if x*sign(sind(gravity_dir)) <= o_mario.x*sign(sind(gravity_dir))
                    move_dir = gravity_dir - 90
                else
                    move_dir = gravity_dir + 90
            }
            else
            {
                if y*sign(cosd(gravity_dir)) <= o_mario.y*sign(cosd(gravity_dir))
                    move_dir = gravity_dir - 90
                else
                    move_dir = gravity_dir + 90
            }
        }
    }
    else
    {
        //water_detect
        if place_meeting_round(x,y,o_water)
        {
            while ( !place_meeting_round(x-16*cosd(gravity_dir),y+16*sind(gravity_dir),o_water) )
            {
                x += cosd(gravity_dir)
                y -= sind(gravity_dir)
            }
        }

        move_v = velocity
        physics_step()

        //get direction
        var draw_dir;
        draw_dir = (gravity_dir - 90) mod 360
        while ( draw_dir < 0)
            draw_dir += 360
        if move_dir = draw_dir
            dir = -1
        else
            dir = 1

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
            death.gravity_dir = gravity_dir

            if atk < 5 || ( atk = 7 && !out_of_frame(64) )
                audio_sound_play("kick_1")

            instance_destroy()
        }

        //out_of_border
        if ( sign(cosd(move_dir)) = 1 && x >= room_width + 32*abs(image_xscale) ) || ( sign(cosd(move_dir)) = -1 && x <= -32*abs(image_xscale) )
        || ( sign(sind(move_dir)) = 1 && y <= -32*abs(image_xscale) ) || ( sign(sind(move_dir)) = -1 && y >= room_height + 32*abs(image_xscale) )
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
    draw_self_scale(dir*image_xscale,image_yscale)
