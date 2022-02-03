#define Draw_0
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

//draw foreground manually
if global.fg_num > 0
{
    var i;
    for(i=0;i<global.fg_num;i+=1)
        draw_bg(global.fg_index[i],global.fg_x[i],global.fg_y[i],global.fg_xscale[i],global.fg_yscale[i],global.fg_htiled[i],global.fg_vtiled[i],global.fg_blend[i],global.fg_alpha[i])
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
