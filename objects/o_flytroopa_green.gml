#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_user(0)
def_bump = -1
instance_init()

turn = false

sprite_fix_offset(16,23)
image_speed = 0.1

xorigin = x
yorigin = y

xradius = 0
yradius = 50
velocity = 2
phase = 0

look = 0
/*
look = 0: look at mario
look = 1: look forward
*/
dir = 1

scores = 100
activate = true
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    var xphase, yphase;
    xphase = xradius*cosd(phase)
    yphase = yradius*sind(phase)
    x = xorigin + xphase*cosd(image_angle) + yphase*sind(image_angle)
    y = yorigin - xphase*sind(image_angle) + yphase*cosd(image_angle)

    if !activate && !out_of_frame(64)
        activate = true
    else
    {
        phase += velocity
        while (phase < 0)
            phase += 360
        phase = phase mod 360

        //look
        if look = 1
        {
            if phase > 180 && phase < 360
                dir = 1
            else
                dir = -1
        }
        else
        {
            if instance_number(o_mario) > 0
            {
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

        //attacked
        event_user(1)

        if atk = 1
        {
            var death;
            death = instance_create(x, y, o_troopa_green)
            death.x = x + 31*image_yscale*sind(image_angle)
            death.y = y + 31*image_yscale*cosd(image_angle)
            death.image_angle = image_angle
            death.image_xscale = image_xscale
            death.image_yscale = image_yscale
            death.activate = true
            death.gravity_dir = image_angle+270
            death.move_dir = (image_angle+270) + dir*90
        }

        if atk > 0
        {
            if atk < 5
            {
                var s;
                s = instance_create((bbox_left+bbox_right)/2, min(bbox_top,bbox_bottom), o_score)
                s.scores = scores
            }

            if atk > 1
            {
                var death;
                death = instance_create(x+23*image_yscale*sind(image_angle), y+23*image_yscale*cosd(image_angle), o_enemy_death)
                death.sprite_index = sprite_duplicate_offset(16,27,s_shell_green)
                death.image_index = 0
                death.image_angle = image_angle
                death.image_xscale = image_xscale
                death.image_yscale = image_yscale
                death.yflip = true
                death.gravity_dir = image_angle+270
                death.gravity_v = -6
                death.move_v = irandom(2) - irandom(2)

                if atk != 5 && atk != 6
                    audio_sound_play("kick_1")
            }

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
