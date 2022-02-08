#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
pause = -1

//script init
md5()
INI_init()
LoadFMOD()
FMODinit(100)
cleanmem_init()
mem = 0

//fonts init
global.font_score = font_add_sprite(s_font_score, ord("0"), 1, 0)
global.font_life = font_add_sprite(s_font_life, ord("0"), 1, 0)
global.font_HUD = font_add_sprite(s_font_HUD, ord("!"), 1, 1)

//data
global.savekey = "dasasdhbasuperdasasdhbamariodasasdhba"
global.audiokey = "dasasdhbavandaldasasdhbaeditordasasdhba"
global.checkkey = "dasasdhbagamedasasdhbamakerdasasdhba"
global.audioext = "fmod"
global.audiocryptext = "fev"
global.soundencrypt = false
global.musicencrypt = false

//audio encrypt
audio_encrypt()

//MD5 set
md5_set()

//sound init
audio_sound_init()

//music channel
global.channel_max = 32
var i;
for (i=0;i<=global.channel_max;i+=1)
{
    global.musicname[i] = ""
    global.musicplay[i] = 0
}

//FMOD music list
global.music_id_list = ds_list_create()
global.music_instance_list = ds_list_create()

//background
light_init()
background_clear()
instance_create(0,0,o_foreground)

//sprite list
global.sprite_list = ds_list_create()

//physics object list
global.physics_object = ds_list_create()

//ignore list
global.ignore_object = ds_list_create()

//control
global.key_up = vk_up
global.key_down = vk_down
global.key_left = vk_left
global.key_right = vk_right
global.key_jump = ord("Z")
global.key_fire = ord("X")
global.key_pause = ord("P")

//setting
global.music = 1
global.sound = 1
global.size = 1
global.fullscreen = false
global.effect = true

//pause
global.pause = false
global.pause_sound = false

//level
global.life = 4
global.scores = 0
global.coin = 0
global.time = -1
global.mario = 0
global.checkpoint = 0
global.checkroom = 0
global.deathroom = 0
global.oneoff = false

//setting init
global.setting_file = ".\Data\Save\setting.ini"
setting_init()

//room refresh
global.room_refresh = false
global.room_screen = 0

//debug
global.debug_inv = false
global.debug_cam = false
global.debug_box = false
global.debug_store = 0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//debug function
if debug_mode && !global.pause
{
    //infinity lives
    global.life = "INF"

    //switch the state of mario
    if keyboard_check_pressed(ord("1"))
        global.mario = 0
    if keyboard_check_pressed(ord("2"))
        global.mario = 1
    if keyboard_check_pressed(ord("3"))
        global.mario = 2
    if keyboard_check_pressed(ord("4"))
        global.mario = 3
    if keyboard_check_pressed(ord("5"))
        global.mario = 4

    //mario invincible
    if keyboard_check_pressed(ord("6"))
    {
        global.debug_inv = 1 - global.debug_inv
        o_mario.invincible = 1 - o_mario.invincible
        o_mario.image_alpha = 1
    }
    if global.debug_inv
    {
        o_mario.image_alpha = 0.5
        o_mario.invincible = true
        o_mario.solid_crush = false
    }

    //view open
    if keyboard_check_pressed(ord("7"))
    {
        o_camera.L = 0
        o_camera.R = room_width
        o_camera.T = 0
        o_camera.B = room_height
    }

    //view move
    if keyboard_check_pressed(ord("8"))
    {
        if !global.debug_cam
        {
            global.debug_store[0] = o_camera.screen_limit
            global.debug_store[1] = o_camera.xoffset
            global.debug_store[2] = o_camera.yoffset
        }
        else
        {
            o_camera.screen_limit = global.debug_store[0]
            o_camera.xoffset = global.debug_store[1]
            o_camera.yoffset = global.debug_store[2]
        }

        global.debug_cam = 1 - global.debug_cam
        o_mario.control = 1 - o_mario.control
        o_mario.fall = 1 - o_mario.fall
    }
    if global.debug_cam
    {
        o_mario.control = false
        o_mario.fall = false
        o_camera.screen_limit = false

        var _h,_v,_s;
        _h = keyboard_check(global.key_right) - keyboard_check(global.key_left)
        _v = keyboard_check(global.key_down) - keyboard_check(global.key_up)
        _s = mouse_wheel_down() - mouse_wheel_up()
        o_camera.xoffset += 10*_h
        o_camera.yoffset += 10*_v
        o_camera.scale_target += 0.1*_s
        o_camera.scale_v = 0.1
    }

    //previous checkpoint
    if keyboard_check_pressed(ord("9"))
    {
        if global.checkpoint > 1
        {
            global.checkpoint -= 1
            with(o_checkpoint)
            {
                if id = global.checkid[global.checkpoint-1]
                {
                    sprite_fix_offset(44,111)
                    o_mario.x = x
                    o_mario.y = y
                    o_mario.angle = image_angle
                    o_mario.gravity_dir = image_angle + 270

                    o_camera.L = 0
                    o_camera.R = room_width
                    o_camera.T = 0
                    o_camera.B = room_height
                }
                else if id = global.checkid[global.checkpoint]
                    activate = false
            }
        }
    }

    //next checkpoint
    if keyboard_check_pressed(ord("0"))
    {
        globalvar _debug_warp;
        _debug_warp = false
        with(o_checkpoint)
        {
            if !_debug_warp && !activate
            {
                sprite_fix_offset(44,111)
                activate = true
                _debug_warp = true
                o_mario.x = x
                o_mario.y = y
                o_mario.angle = image_angle
                o_mario.gravity_dir = image_angle + 270
                global.checkid[global.checkpoint] = id
                global.checkpoint += 1

                o_camera.L = 0
                o_camera.R = room_width
                o_camera.T = 0
                o_camera.B = room_height
            }
        }
    }

    //show hitbox
    if keyboard_check_pressed(vk_tab)
    {
        global.debug_box = 1 - global.debug_box

        if global.debug_box
        {
            o_solid.visible = true
            o_platform.visible = true
            o_bonus.visible = true
        }
        else
        {
            o_solid.visible = false
            o_platform.visible = false
            o_elecoral.visible = true
            o_block_ice.visible = true
            o_block_switch.visible = true
            o_cannon.visible = true
            o_cannon_follow.visible = true
            o_solid_moving.visible = true
            o_platform_moving.visible = true
            with(o_block)
            {
                if !hidden
                    visible = true
            }
            with(o_bonus)
            {
                if bonus_place
                    visible = false
            }
        }
    }

    //click to move mario
    if mouse_check_button_pressed(mb_right)
    {
        o_mario.x = mouse_x
        o_mario.y = mouse_y
    }

}
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=o_solid_moving
*/
//event for o_solid_moving
if !global.pause
{
    xorigin = round(x)
    yorigin = round(y)
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=o_platform_moving
*/
//event for o_platform_moving
if !global.pause
{
    xorigin = round(x)
    yorigin = round(y)
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//enable the camera
if instance_number(o_mario) > 0 && instance_number(o_camera) = 0
    instance_create(o_mario.x,o_mario.y-14,o_camera)
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=o_solid_moving
*/
//event for o_solid_moving
if !global.pause
{
    if moving_state != -1
        moving_motion()

    dx = round(x) - xorigin
    dy = round(y) - yorigin
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=o_platform_moving
*/
//event for o_platform_moving
if !global.pause
{
    if moving_state != -1
        moving_motion()

    dx = round(x) - xorigin
    dy = round(y) - yorigin
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=o_camera
*/
//event for o_camera
if !global.pause
{
    //scale
    var scale_max;
    scale_max = min((R-L)/view_wport[0],(B-T)/view_hport[0])
    if scale_target > scale_max
        scale_target = scale_max

    if scale != scale_target
    {
        if scale_v <= 0
            scale = scale_target
        else
            scale += (scale_target-scale)*scale_v

        var worigin, horigin;
        worigin = view_wview[0]
        horigin = view_hview[0]

        view_wview[0] = mround(view_wport[0]*scale)
        view_hview[0] = mround(view_hport[0]*scale)

        x += (view_wview[0] - worigin)/2
        y += (view_hview[0] - horigin)/2
    }

    //move
    if mode = 0
    {

        // target mario
        if target_mario && instance_number(o_mario) > 0
        {
            xtarget = mround(o_mario.x) + xoffset
            ytarget = mround(o_mario.y-14) + yoffset
        }

        //fix the target
        if xtarget < L + mround(view_wview[0]/2)
            xtarget = L + mround(view_wview[0]/2)
        if xtarget > R - mround(view_wview[0]/2)
            xtarget = R - mround(view_wview[0]/2)
        if ytarget < T + mround(view_hview[0]/2)
            ytarget = T + mround(view_hview[0]/2)
        if ytarget > B - mround(view_hview[0]/2)
            ytarget = B - mround(view_hview[0]/2)

        //moving
        if gradual_x
        {
            var vx;
            vx = (xtarget-x)*gradual_vx
            x += sign(vx)*min(gradual_xmax,max(gradual_xmin,abs(vx)))
        }
        else if follow_vx > 0
            x += (xtarget-x)*follow_vx
        else
            x = xtarget

        if gradual_y
        {
            var vy;
            vy = (ytarget-y)*gradual_vy
            y += sign(vy)*min(gradual_ymax,max(gradual_ymin,abs(vy)))
        }
        else if follow_vy > 0
            y += (ytarget-y)*follow_vy
        else
            y = ytarget

    }
    else if mode = 1
    {
        x += move_v*cosd(move_dir)
        y -= move_v*sind(move_dir)
    }
    else if mode = 2
    {
        screen_limit = false
        gradual_x = false
        gradual_y = false

        // target mario
        if target_mario && instance_number(o_mario) > 0
        {
            xtarget = mround(o_mario.x)
            ytarget = mround(o_mario.y-14)
        }

        x = L + floor((xtarget-L)/view_wview[0])*view_wview[0] + mround(view_wview[0]/2)
        y = T + floor((ytarget-T)/view_hview[0])*view_hview[0] + mround(view_hview[0]/2)
    }

    //cancel the gradual change
    if gradual_x && abs(x-xtarget) <= gradual_xmin
        gradual_x = false
    if gradual_y && abs(y-ytarget) <= gradual_ymin
        gradual_y = false

    //self moving mode
    if mode = 1
    {
        var xo, yo;
        xo = x
        yo = y
    }

    //shake
    var xorigin,yorigin;
    xorigin = x
    yorigin = y
    if shake != 0
    {
        shake -= sign(shake)
        x = xorigin + irandom(shake_range) - irandom(shake_range)
        y = yorigin + irandom(shake_range) - irandom(shake_range)
    }

    //fix the border
    if shake >= 0
    {
        if !gradual_x
        {
            if x < L + mround(view_wview[0]/2)
            {
                x = L + mround(view_wview[0]/2)
                xorigin = x
            }
            if x > R - mround(view_wview[0]/2)
            {
                x = R - mround(view_wview[0]/2)
                xorigin = x
            }
        }

        if !gradual_y
        {
            if y < T + mround(view_hview[0]/2)
            {
                y = T + mround(view_hview[0]/2)
                yorigin = y
            }
            if y > B - mround(view_hview[0]/2)
            {
                y = B - mround(view_hview[0]/2)
                yorigin = y
            }
        }
    }

    //set the view
    view_xview[0] = mround(x) - mround(view_wview[0]/2)
    view_yview[0] = mround(y) - mround(view_hview[0]/2)
    x = xorigin
    y = yorigin

    //screen limit
    if screen_limit && instance_number(o_mario) > 0 && o_mario.pipe = 0
    {
        var dir;
        dir = o_mario.gravity_dir
        if ( dir > 225 && dir < 315 ) || ( dir > 45 && dir < 135 )
        {
            var mleft, mright;
            mleft = min(o_mario.bbox_left, o_mario.bbox_right)
            mright = max(o_mario.bbox_left, o_mario.bbox_right)

            if mleft < mround(x) - mround(view_wview[0]/2)
            {
                o_mario.x += mround(x) - mround(view_wview[0]/2) - mleft
                with (o_mario)
                {
                    x = mround(x)
                    if physics_place(x,y,1)
                        death = true
                    move_v = 0
                    velocity = 0
                    if gravity_state = 0 && !crouch && !crouch_fix && change = 0
                        image_index = 0
                }
            }

            if mright > mround(x) + mround(view_wview[0]/2)
            {
                o_mario.x += mround(x) + mround(view_wview[0]/2) - mright
                with (o_mario)
                {
                    x = mround(x)
                    if physics_place(x,y,1)
                        death = true
                    move_v = 0
                    velocity = 0
                    if gravity_state = 0 && !crouch && !crouch_fix && change = 0
                        image_index = 0
                }
            }
        }
        else
        {
            var mtop, mbottom;
            mtop = min(o_mario.bbox_top, o_mario.bbox_bottom)
            mbottom = max(o_mario.bbox_top, o_mario.bbox_bottom)

            if mtop < mround(y) - mround(view_hview[0]/2)
            {
                o_mario.y += mround(y) - mround(view_hview[0]/2) - mtop
                with (o_mario)
                {
                    y = mround(y)
                    if physics_place(x,y,1)
                        death = true
                    move_v = 0
                    velocity = 0
                    if gravity_state = 0 && !crouch && !crouch_fix && change = 0
                        sprite_index = 0
                }
            }

            if mbottom > mround(y) + mround(view_hview[0]/2)
            {
                o_mario.y += mround(y) + mround(view_hview[0]/2) - mbottom
                with (o_mario)
                {
                    y = mround(y)
                    if physics_place(x,y,1)
                        death = true
                    move_v = 0
                    velocity = 0
                    if gravity_state = 0 && !crouch && !crouch_fix && change = 0
                        sprite_index = 0
                }
            }
        }

    }

    //self moving mode
    if mode = 1
    {
        x = xo
        y = yo
    }

}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=o_camera_auto
*/
//event for o_camera_auto
if !global.pause
{
    if first && !activate
    {
        activate = true
        first = false
        event_user(1)
    }

    if activate && next != noone
    {
        if ( cosd(o_camera.move_dir) != 0 && o_camera.x*cosd(o_camera.move_dir) >= next.x*cosd(o_camera.move_dir) )
        || ( sind(o_camera.move_dir) != 0 && o_camera.y*sind(o_camera.move_dir) <= next.y*sind(o_camera.move_dir) )
        {
            activate = false
            next.activate = true
            with(next)
                event_user(1)
        }
    }
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with(all)
{
    //pause
    if pause = 0 && global.pause
    {
        pause = 1
        pause_index = image_index
        pause_speed = image_speed
        image_speed = 0
    }

    if pause = 1
    {
        image_index = pause_index
        image_speed = 0
        if !global.pause
        {
            pause = 0
            image_speed = pause_speed
        }
    }

}

//physics object
if !global.pause
{
    var i;
    for(i=0;i<ds_list_size(global.physics_object);i+=1)
    {
        with(ds_list_find_value(global.physics_object,i))
        {
            water_in = false
            water_out = false

            gravity_hit_up = false
            gravity_hit_down = false

            move_hit = false

            auto_finish = false

            if ( ( gravity_place && gravity_state != -1 ) || ( move_place && move_state != -1 ) )
                physics_moving_fix()

        }
    }

    with(o_solid_moving)
        event_user(0)
    with(o_platform_moving)
        event_user(0)

    for(i=0;i<ds_list_size(global.physics_object);i+=1)
    {
        with(ds_list_find_value(global.physics_object,i))
        {
            physics_moving_T = false
            physics_moving_D = false
            physics_moving_L = false
            physics_moving_R = false

            if gravity_fix_vx != 0
            {
                x += gravity_fix_vx
                if physics_place(x,y,1)
                {
                    if gravity_fix_vx > 0
                        physics_fix(x,y,180,1)
                    else
                        physics_fix(x,y,0,1)
                }
            }
            if gravity_fix_vy != 0
            {
                y += gravity_fix_vy
                if physics_place(x,y,1)
                {
                    if gravity_fix_vy > 0
                        physics_fix(x,y,90,1)
                    else
                        physics_fix(x,y,270,1)
                }
            }
            gravity_fix_vx = 0
            gravity_fix_vy = 0
        }
    }

}

//show background
if script_exists(global.background)
    script_execute(global.background)

//clean memory
mem += 1
if mem >= 10
{
    cleanmem()
    mem = 0
}

//FMOD System
FMODUpdate()

//free the music
audio_music_refresh()

//free physics object
physics_free()

//pause the sound
if global.pause && !global.pause_sound
{
    global.pause_sound = true
    audio_pause_all()
}

if !global.pause && global.pause_sound
{
    global.pause_sound = false
    audio_resume_all()
}
#define Other_3
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//script unload
cleanmem_init(1)
FMODfree()
UnloadFMOD()

//list clear
ds_list_destroy(global.music_id_list)
ds_list_destroy(global.music_instance_list)
ds_list_destroy(global.sprite_list)
#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//set the caption
room_caption = "Super Mario Vandal Editor"

//check whether the MD5 is right
if !md5_check()
    game_end()
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//free the duplicated sprite
sprite_free()

//room refresh
if room != r_start && room != r_restart
{
    global.room_refresh = true
    if sprite_exists(global.room_screen)
        sprite_delete(global.room_screen)
    global.room_screen = sprite_create_from_screen(0, 0, view_wport[0], view_hport[0], 0, 0, 0, 0)
    o_foreground.depth = -10000000
}
#define Other_30
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
game_end()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//draw background manually
if global.bg_num > 0
{
    var i;
    for(i=0;i<global.bg_num;i+=1)
        draw_background_adv(global.bg_index[i],global.bg_x[i],global.bg_y[i],global.bg_xscale[i],global.bg_yscale[i],global.bg_htiled[i],global.bg_vtiled[i],global.bg_blend[i],global.bg_alpha[i])
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//water surface
if global.water_surface > 0 && global.water_gap > 0 && instance_number(o_water_surface_auto) > 0
{
    var i,j;
    for(i=global.water_surface;i>0;i-=1)
    {
        j = 0
        var draw_x;
        draw_x = parallax_x((global.water_surface-i+1)/(global.water_surface+1))
        draw_x += floor((view_xview[0]-draw_x)/960)*960
        while( draw_x + 960*j < view_xview[0]+view_wview[0] )
        {
            draw_sprite_ext(s_water_effect,o_water_surface_auto.image_index,draw_x + 960*j,o_water_surface_auto.y-global.water_gap*i,1,1,0,c_white,o_water_surface_auto.image_alpha*(global.water_surface-i+1)/(global.water_surface+1))
            j += 1
        }
    }
}
