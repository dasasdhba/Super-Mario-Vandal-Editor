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
