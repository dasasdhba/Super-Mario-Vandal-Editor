#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_init()
pause = -1

number = 6
xradius = 160
yradius = 160
velocity = 1
phase = 0
#define Step_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var i;
for (i=0;i<number;i+=1)
{
    var troopa;
    troopa = instance_create(x, y, o_flytroopa_gold)
    troopa.xorigin = x + 16*image_xscale
    troopa.yorigin = y + 16*image_yscale
    troopa.image_xscale = image_xscale
    troopa.image_yscale = image_yscale
    troopa.xradius = xradius
    troopa.yradius = yradius
    troopa.velocity = velocity
    troopa.phase = phase + i*(360/number)
}

instance_destroy()
