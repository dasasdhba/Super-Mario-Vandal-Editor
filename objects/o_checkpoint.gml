#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()

image_speed = 0
activate_speed = 0.1

activate = false

//mario reborn
if global.checkpoint < 0
{
    global.checkpoint *= -1
    var i;
    for(i=0;i<global.checkpoint;i+=1)
    {
        with(o_checkpoint)
        {
            if id = global.checkid[i]
            {
                activate = true
                if i = global.checkpoint - 1
                {
                    sprite_fix_offset(44,111)
                    o_mario.x = x
                    o_mario.y = y
                    o_mario.image_angle = image_angle
                    o_mario.gravity_dir = image_angle + 270
                    o_mario.sprite_index = sprite_duplicate_offset(16,31,o_mario.sprite_index)
                    //disable default music and background
                    with(o_mario)
                    {
                        if place_meeting(x,y,o_music)
                            with(o_music_default)
                                instance_destroy()

                        if place_meeting(x,y,o_background)
                            with(o_background_default)
                                instance_destroy()
                    }

                }
            }
        }
    }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    //activate
    if !activate && place_meeting(x,y,o_mario) && o_mario.pipe = 0
    {
        activate = true
        audio_sound_play("sprout")
        global.checkid[global.checkpoint] = id
        global.checkpoint += 1
        global.checkroom = room
    }


    //animation
    if !activate
    {
        image_index = 0
        image_speed = 0
    }
    else
        image_play(1,2,activate_speed)

}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !out_of_frame()
    draw_self()
