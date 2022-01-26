if global.checkpoint < 0
{
    global.checkpoint *= -1
    room_goto(global.checkroom)
}
else
    room_goto(global.deathroom)
