#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var block;
do
{
    block = instance_place(x,y,o_block)
    if block
    {
        if !global.oneoff
        {
            block.hidden = true
            block.type = -1
            block.visible = false
            instance_deactivate_object(block)
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
}
until( !block )
instance_activate_object(o_block)
instance_destroy()
