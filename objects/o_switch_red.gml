#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
pause = -1

sprite_fix_offset(16,16)

if !variable_local_exists("type")
    type = 0

if !variable_local_exists("hidden")
    hidden = false

block = o_block_red
block_sprite = block.sprite_index

hit = false
ani = 0
