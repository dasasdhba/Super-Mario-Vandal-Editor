#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var block;
block = instance_place(x,y,o_block)
if block
{
    if !global.oneoff
    {
        block.hidden = true
        block.type = -1
        block.visible = false
    }
    else
    {
        if item
        {
            with(item)
                instance_destroy()
        }
        instance_destroy()
    }
}

instance_destroy()
