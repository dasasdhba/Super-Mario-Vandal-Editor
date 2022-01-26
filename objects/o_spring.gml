#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()

image_speed = 0
ani_speed = 0.3

v_unjump = -11
v_jump = -19
time = 7

count = 0
ani = false
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    if o_mario.control && o_mario.pipe = 0 && keyboard_check_pressed(global.key_jump)
        count = time

    if place_meeting(x,y,o_mario) && !place_meeting(x,y+sprite_height/2,o_mario) && o_mario.gravity_v > 0 && o_mario.pipe = 0
    {
        audio_sound_play("spring")
        ani = true

        if count = 0
            o_mario.gravity_v = v_unjump
        else
            o_mario.gravity_v = v_jump
    }

    if count > 0
        count -= 1

    if ani = false
    {
        image_speed = 0
        image_index = 0
    }
    else
    {
        ani_play = image_play(1,4,ani_speed)
        if image_index > 3.5
        {
            image_speed = 0
            image_index = 0
            ani = false
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
    draw_self()
