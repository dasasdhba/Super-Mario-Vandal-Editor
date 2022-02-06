//instance_ignore(obj)
//the instance_deactivate_object will break the layer order
if !argument0._ignore_
{
    argument0._ignore_ = true
    argument0._ignore_x_ = argument0.x
    argument0.x = -99999999
}
