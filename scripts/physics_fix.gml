//physics_fix(x,y,dir,setting,depth)
/*setting
= 0: fix solid and platform
= 1: fix solid
= 2: fix platform
depth is for the platform
*/

var fix_x, fix_y, fix_set, fix_depth;
fix_x = argument0
fix_y = argument1

if argument_count >= 4
    fix_set = argument3
else
    fix_set = 0

if argument_count = 5
    fix_depth = argument4
else
    fix_depth = 0

while ( physics_place(fix_x,fix_y,fix_set,fix_depth) )
{
    fix_x += cosd(argument2)
    fix_y -= sind(argument2)
}

x = mround(fix_x)
y = mround(fix_y)
return true;
