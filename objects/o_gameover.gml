#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
audio_sound_play("gameover")

count = 0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    count += 1
    if count >= 300 && keyboard_check_pressed(vk_anykey)
        game_restart()
}
