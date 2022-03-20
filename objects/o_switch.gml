#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    //hit by Mario
    if !hit
    {
        if o_mario.gravity_hit_up && place_meeting_round(x+cosd(o_mario.gravity_dir), y-sind(o_mario.gravity_dir), o_mario)
        {
            hit = true

            var b;
            b = instance_create(x-16*image_yscale*sind(image_angle),y-16*image_yscale*cosd(image_angle),o_bump)
            b.image_xscale = image_xscale
            b.image_angle = image_angle
        }
        if hidden && o_mario.gravity_v < 0 && place_meeting(x, y, o_mario) && !place_meeting_round(x-16*cosd(o_mario.gravity_dir), y+16*sind(o_mario.gravity_dir), o_mario)
        {
            hit = true
            type = 0

            var b;
            b = instance_create(x-16*image_yscale*sind(image_angle),y-16*image_yscale*cosd(image_angle),o_bump)
            b.image_xscale = image_xscale
            b.image_angle = image_angle

            with(o_mario)
            {
                var hidden_fix;
                hidden_fix = physics_fix(x,y,gravity_dir,1,16)
                if hidden_fix
                {
                    gravity_v = 0
                    gravity_hit_up = true
                }
                else
                    crouch_fix = true
            }
        }
    }

    //switch
    if hit && !hit_delay
    {
        hit_delay = true
        ani = 8
        audio_sound_play("switch")
        with(block)
            state *= -1
    }

    //hit animation
    if ani > 0
    {
        ani -= 1
        if ani = 0 && hit_delay
        {
            hit_delay = false
            hit = false
        }
    }

}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !out_of_frame(4)
{
    if ani = 0
        draw_self()
    else
    {
        var d, b;
        d = 4 - abs(ani-4)
        b = sprite_duplicate_offset(16,16,block_sprite)
        draw_sprite_ext(b, 0, x-d*cosd(image_angle-90), y+d*sind(image_angle-90), image_xscale, image_yscale, image_angle, image_blend, image_alpha)
    }
}
