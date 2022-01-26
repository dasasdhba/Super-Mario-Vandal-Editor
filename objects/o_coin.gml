#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
image_speed = 0.2

coin = 1
scores = 200
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    if place_meeting_round(x,y,o_mario) && o_mario.pipe = 0
    {
        audio_sound_play("coin")
        global.coin += coin
        global.scores += scores
        instance_destroy()
    }

    if place_meeting(x,y,o_bump)
    {
        audio_sound_play("coin")

        var c;
        c = instance_create((bbox_left+bbox_right)/2,(bbox_top+bbox_bottom)/2,o_coin_effect)
        c.coin = coin
        c.scores = scores

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
