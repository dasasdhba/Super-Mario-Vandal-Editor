#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
sprite_fix_offset(16,16)

if !variable_local_exists("type")
    type = 0

image_speed = 0.1

if !variable_local_exists("hidden")
    hidden = false
hit = false
coin = 1

create = false
ani = 8

var c;
c = instance_place(x,y,o_coin)
if c
{
    coin = c.coin
    with(c)
    {
        instance_destroy()
    }
}

item = instance_place(x,y,o_bonus)
if item
{
    item.visible = false
    item.bonus_place = true
}
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

    //create item
    if hit && !create
    {
        create = true
        hidden = false
        visible = true
        type = 0

        if !item
        {
            audio_sound_play("coin")
            var c;
            c = instance_create(x-32*image_yscale*sind(image_angle),y-32*image_yscale*cosd(image_angle), o_coin_effect)
            c.image_xscale = image_xscale
            c.image_yscale = image_yscale
            c.image_angle = image_angle
            c.gravity_dir = image_angle - 90
            c.coin = coin
        }
        else
        {
            audio_sound_play("sprout")
            if item.mushroom && global.mario = 0
            {
                var m;
                m = instance_create(x,y,o_mushroom_red)
                m.x = item.x
                m.y = item.y
                m.activate = true
                m.image_xscale = item.image_xscale
                m.image_yscale = item.image_yscale
                m.image_angle = item.image_angle
                m.gravity_dir = item.gravity_dir
                m.depth = depth + 1
                with(item)
                {
                    instance_destroy()
                }
            }
            else
            {
                item.bonus_place = false
                item.activate = true
                item.visible = true
                item.depth = depth + 1
            }
        }
    }

    //hit animation
    if hit && ani > 0
        ani -= 1

}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !out_of_frame(4)
{
    if !hit
        draw_self()
    else
    {
        var d;
        d = 4 - abs(ani-4)
        draw_sprite_ext(s_block_bump, 0, x-d*cosd(image_angle-90), y+d*sind(image_angle-90), image_xscale, image_yscale, image_angle, image_blend, image_alpha)
    }
}
