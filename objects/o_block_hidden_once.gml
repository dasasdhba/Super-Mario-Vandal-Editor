#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()

var block;
block = instance_place(x, y, o_block)
if block
{
    if !global.oneoff
    {
        block.hidden = true
        block.type = -1
        block.visible = false
    }
    else
        with(block)
        {
            if item
                with(item)
                {
                    instance_destroy()
                }
            instance_destroy()
        }

}

instance_destroy()
