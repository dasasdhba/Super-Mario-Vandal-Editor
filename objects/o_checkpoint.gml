#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()

sprite_fix_offset(44,111)
image_speed = 0
activate_speed = 0.1

activate = false
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
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//mario reborn
if global.checkpoint > 0
{
    var i;
    for(i=0;i<global.checkpoint;i+=1)
    {
        if id = global.checkid[i]
        {
            activate = true
            if i = global.checkpoint - 1
            {
                o_mario.x = x
                o_mario.y = y
                o_mario.image_angle = image_angle
                o_mario.gravity_dir = image_angle + 270
            }
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
