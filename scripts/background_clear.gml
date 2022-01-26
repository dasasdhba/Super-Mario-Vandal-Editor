//background_clear()
global.background = 0
global.bg_num = 0
var i;
for(i=0;i<8;i+=1)
{
    background_visible[i] = false
    //add more variables if you need
    global.back_vx[i] = 0
    global.back_vy[i] = 0
    global.back_va[i] = 0
}
