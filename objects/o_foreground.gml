#define Other_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
srf_mask = surface_create(view_wport[0], view_hport[0])
srf_light = surface_create(view_wport[0], view_hport[0])
draw_stop = false
#define Other_5
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
surface_free(srf_mask)
surface_free(srf_light)
draw_stop = true
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//draw foreground manually
if global.fg_num > 0
{
    var i;
    for(i=0;i<global.fg_num;i+=1)
        draw_background_adv(global.fg_index[i],global.fg_x[i],global.fg_y[i],global.fg_xscale[i],global.fg_yscale[i],global.fg_htiled[i],global.fg_vtiled[i],global.fg_blend[i],global.fg_alpha[i])
}

//draw hitbox
if global.debug_box
{
    with(o_mario)
        draw_sprite_ext(mask_index, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, 0.75)
    with(o_block)
    {
        if hidden
            draw_sprite_ext(s_block_hidden, 0, x-16*cosd(image_angle)-16*sind(image_angle), y+16*sind(image_angle)-16*cosd(image_angle), image_xscale, image_yscale, image_angle, image_blend, 0.75)
    }
    with(o_brick)
    {
        if coin_brick && !create
            draw_sprite_ext(s_coin, 0, x-16*cosd(image_angle)-16*sind(image_angle), y+16*sind(image_angle)-16*cosd(image_angle), image_xscale, image_yscale, image_angle, image_blend, image_alpha*0.75)
    }
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//light system
if global.light > 0 && !draw_stop
{
    surface_set_target(srf_light)
    draw_clear_alpha(c_black,0)
    var i, scale;
    scale = view_wport[0]/view_wview[0]
    for(i=0;i<ds_list_size(global.light_list);i+=1)
    {
        with(ds_list_find_value(global.light_list,i))
        {
            if !out_of_frame(320*scale)
                draw_sprite_ext(s_light_effect,0,(bbox_left+bbox_right)/2-view_xview[0],(bbox_top+bbox_bottom)/2-view_yview[0],scale,scale,0,c_black,1)
        }
    }

    surface_set_target(srf_mask)
    draw_clear(c_black)
    draw_set_blend_mode(bm_subtract)
    draw_surface(srf_light,0,0)
    draw_set_blend_mode(bm_normal)

    surface_reset_target()
    draw_surface_ext(srf_mask,0,0,1,1,0,c_white,global.light)
}
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//room refresh
if global.room_refresh
{
    draw_sprite(global.room_screen, 0, 0, 0)
    global.room_refresh = false
    depth = -999
}
