#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
pause = -1

sep = 20

player = "MARIO"
name = "WORLD"
time = 360

xplayer = 32
yplayer = 16
xscore = 32
yscore = 36
xcoin = 32
ycoin = view_hport[0]-32
xname = view_wport[0]/2
yname = 16
xtime = view_wport[0]-58
ytime = 16

shake_time = 100

time_init = false
time_count = 0
coin_count = 0
coin_ani = 0
shake_count = 0
shake_pos = 0

/*
color = make_color_rgb(0,0,112)

outline_num = 10
outline = 2
outline_alpha = 1

extend_num = 10
extend = 1.4
extend_alpha = 0.15
*/
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    coin_count += 1
    if coin_count >= 6
    {
        coin_count = 0
        coin_ani += 1
        coin_ani = coin_ani mod 3
    }

    if global.coin >= 100 && instance_number(o_mario) > 0
    {
        global.coin -= 100
        with(o_mario)
            instance_create((bbox_left+bbox_right)/2,bbox_top,o_life)
    }

    if !time_init
    {
        if time <= 0
            global.time = -1
        else if global.time < 0
        {
            global.time = time
            time *= -1
        }

        time_init = true
    }

    if global.time > 0 && instance_number(o_mario) > 0 && o_mario.pipe = 0 && !o_mario.pass
    {
        time_count += 1
        if time_count >= 25
        {
            time_count = 0
            global.time -= 1
        }

        if global.time = 0 && !debug_mode
            o_mario.death = true

        if global.time <= 100 && shake_count = 0
        {
            audio_sound_play("timeout")
            shake_count = shake_time
        }
    }

    shake_pos = 0
    if shake_count > 0
    {
        shake_pos = random(shake_count/10)-random(shake_count/10)
        shake_count -= 1
        if shake_count = 0
            shake_count = -1
    }

    if shake_count = -1 && global.time > 100
        shake_count = 0
}
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
srf_text = surface_create(view_wport[0], view_hport[0])
//srf_mask = surface_create(view_wport[0], view_hport[0])
//srf_color = surface_create(view_wport[0], view_hport[0])
draw_stop = false
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
surface_free(srf_text)
//surface_free(srf_mask)
//surface_free(srf_color)
draw_stop = true
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !draw_stop
{
    //draw the text to the surface srf_text
    surface_set_target(srf_text)
    draw_clear_alpha(c_black,0)
    draw_set_font(global.font_HUD)
    draw_set_alpha(1)
    draw_set_color(c_white)

    if is_real(global.life)
        draw_text(xplayer, yplayer, player+" ~ "+string(global.life))
    else
        draw_text(xplayer, yplayer, player+" ~ "+global.life)

    draw_text(xscore, yscore, string(global.scores))
    draw_text(xcoin, ycoin, string_char_at("{|}",coin_ani+1)+" ~ "+string(global.coin))

    draw_set_halign(fa_center)
    draw_text_ext(xname,yname,name,sep,-1)
    if global.time >= 0
        draw_text_ext(xtime+shake_pos,ytime+shake_pos,"TIME#"+string(global.time),sep,-1)

    draw_set_valign(fa_center)
    if instance_number(o_gameover) > 0
        draw_text(view_wport[0]/2,view_hport[0]/2,"GAME OVER")

    draw_set_halign(fa_left)
    draw_set_valign(fa_top)

    //draw the outline mask
    /*
    surface_set_target(srf_mask)
    draw_clear(c_black)

    draw_set_blend_mode(bm_subtract)
    draw_surface_ext(srf_text, 0, 0, 1, 1, 0, c_black, 1)

    var i;
    if outline_num > 0
        for (i=0;i<360;i+=360/(outline_num))
            draw_surface_ext(srf_text, outline*cosd(i), outline*sind(i), 1, 1, 0, c_black, outline_alpha)
    if extend_num > 0
        for (i=0;i<360;i+=360/(extend_num))
            draw_surface_ext(srf_text, outline*extend*cosd(i), outline*extend*sind(i), 1, 1, 0, c_black, extend_alpha)

    draw_set_blend_mode(bm_normal)

    //draw the outline color
    surface_set_target(srf_color)
    draw_clear(color)

    draw_set_blend_mode(bm_subtract)
    draw_surface(srf_mask, 0, 0)
    draw_set_blend_mode(bm_normal)
    */

    //draw the final result
    surface_reset_target()
    //draw_surface(srf_color, 0, 0)
    draw_surface(srf_text, 0, 0)

}
