//instance_ignore(obj)
//the instance_deactivate_object will break the layer order
with(argument0)
{
    if !_ignore_
    {
        _ignore_ = true
        _ignore_x_ = x
        x = -99999999
    }
}
