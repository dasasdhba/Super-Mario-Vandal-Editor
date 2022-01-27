#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()

count = 0

scores = 0
alpha = 1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !global.pause
{
    if count = 0
        global.scores += scores

    count += 1
    if count < 30
        y -= 2
    if y < view_yview[0]
        y = view_yview[0]

    if count > 90
    {
        if global.effect
            alpha = 1-(count-90)/20.0
        else
            instance_destroy()
    }

    if alpha <= 0
        instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_font(global.font_score)
draw_set_halign(fa_center)
draw_text_alpha(x-view_xview[0],y-view_yview[0],string(scores),alpha)
draw_set_halign(fa_left)
