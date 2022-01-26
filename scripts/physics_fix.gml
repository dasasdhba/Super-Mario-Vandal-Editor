//physics_fix(x,y,dir,setting,depth)
/*setting
= 0: fix solid and platform and return true or false
= 1: fix solid and return true or false
= 2: fix platform and return true or false

depth is the max distance, return false if the distance is greater than this value
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

if fix_depth > 0
{
    var fix_count;
    fix_count = 0
}

while ( physics_place(fix_x,fix_y,fix_set,fix_depth) )
{
    fix_x += cosd(argument2)
    fix_y -= sind(argument2)

    if fix_depth > 0
    {
        fix_count += 1
        if fix_count > fix_depth
            return false;
    }

}

x = mround(fix_x)
y = mround(fix_y)
return true;
