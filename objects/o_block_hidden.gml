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
    block.hidden = true
    block.type = -1
    block.visible = false
}

instance_destroy()
