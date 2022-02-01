//hurt_mario(setting=0)
//setting = 0: hurt, = other: death
var _setting;
if argument_count = 0
    _setting = 0
else
    _setting = argument0

if _setting = 0
{
    if place_meeting_round(x,y,o_mario) && !o_mario.invincible && o_mario.pipe = 0
    {
        o_mario.hurt = o_mario.hurt_time
        return true;
    }
}
else
{
    if place_meeting_round(x,y,o_mario) && o_mario.pipe = 0 && !global.debug_inv
    {
        o_mario.death = true
        return true;
    }
}

return false;
