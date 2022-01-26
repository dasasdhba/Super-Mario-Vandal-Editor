#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//this user event should be called in Create Event
enemy = true
hurt = true // hurt mario
hurt_flag = false
turn = true // turn when colliding with the other enemies
turn_flag = false

head = 16 // the hitbox's height for being stomped

shell = 0
shell_atk = false
shell_count = 0
/* shell defines the enemy's "hardness"
if shell_atk = true, the enemy will attack the other enemies
shell = 0: normal shell
shell = 1: hard shell
...
*/

atk = 0
/*
atk = 1: stomp
atk = 2: fireball
atk = 3: beet
atk = 4: bump
atk = 5: shell
atk = 6: star
atk = 7: death (such as lava, bomb)

*/

/* def defines how the enemy responds with the attack
>0: variable atk will be set to the corresponding value
=0: attack will not hurt the enemy
<0: attack will be ignored
in some case, =0 and <0 is the same, such as bump, shell, star and so on
*/
def_stomp = 1
def_fireball = 1
def_beet = 1
def_bump = 1
def_shell = 1
def_star = 1
//the value of following attacks is 7(death), which will not be affected by the invincible state
def_lava = 1
def_crush = 1

invincible = false
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//this user event should be called in Step Event

//hurt mario
hurt_flag = false
if hurt
{
    var mario;
    mario = instance_place(x, y, o_mario)
    if mario && !mario.invincible && o_mario.pipe = 0
    {
        if def_stomp < 0 || place_meeting(x+head*cosd(mario.gravity_dir), y-head*sind(mario.gravity_dir), mario)
        {
            mario.hurt = mario.hurt_time
            hurt_flag = true
        }
    }
}

//turn
if turn && !turn_flag && move_v > 0
{
    var enemy_obj;
    enemy_obj = instance_place(x, y, o_enemy)
    if enemy_obj && enemy_obj.turn
    {
        move_dir += 180
        turn_flag = true
        if !enemy_obj.turn_flag && enemy_obj.move_v > 0
        {
            enemy_obj.move_dir += 180
            enemy_obj.turn_flag = true
        }
    }
}

if turn_flag && !place_meeting(x, y, o_enemy)
    turn_flag = false

//attacked
if !invincible
{
    if def_stomp >= 0 && ( mario.star = 0 || def_star <= 0 )
    {
        var mario;
        mario = instance_place(x, y, o_mario)
        if mario && mario.gravity_state = 1 && mario.gravity_v >= 0 && !place_meeting(x+head*cosd(mario.gravity_dir), y-head*sind(mario.gravity_dir), mario)
        {
            mario.stomp = true
            if def_stomp > 0
                atk = 1
        }
    }

    if def_fireball >= 0
    {
        var fireball;
        fireball = instance_place(x, y, o_fireball_mario)
        if fireball
        {
            fireball.explode = true
            if def_fireball > 0
                atk = 2
        }
    }

    if def_beet >= 0
    {
        var beet;
        beet = instance_place(x, y, o_beet_mario)
        if beet && !beet.explode
        {
            beet.bounce = true
            if def_beet > 0
                atk = 3
        }
    }

    if def_bump > 0 && instance_place(x, y, o_bump)
        atk = 4

    if def_star > 0
    {
        var mario;
        mario = instance_place(x, y, o_mario)
        if mario && mario.star > 0 && mario.pipe = 0
        {
            atk = 6
            mario.star_count += 1
            mario.star_count *= -1
        }
    }

}

//shell attack
if shell_atk
{
    var kick_obj;
    kick_obj = instance_place(x, y, o_enemy)
    if kick_obj && kick_obj.def_shell > 0 && !kick_obj.invincible
    {
        if invincible
        {
            kick_obj.atk = 5
            shell_count += 1
            shell_count *= -1
        }
        else if kick_obj.shell_atk
        {
            if shell < kick_obj.shell && def_shell > 0
            {
                atk = 5
                kick_obj.shell_count += 1
                kick_obj.shell_count *= -1
            }
            else if shell > kick_obj.shell
            {
                kick_obj.atk = 5
                shell_count += 1
                shell_count *= -1
            }
            else if shell = kick_obj.shell
            {
                if def_shell > 0
                    atk = 5
                kick_obj.atk = 5
                audio_sound_play("kick_1")
            }
        }
        else
        {
            if shell < kick_obj.shell && def_shell > 0
            {
                atk = 5
                audio_sound_play("kick_1")
            }
            else
            {
                kick_obj.atk = 5
                shell_count += 1
                shell_count *= -1
            }
        }
    }
}

if physics && solid_cruch && def_crush > 0
    atk = 7

if def_lava > 0 && place_meeting(x, y, o_lava)
    atk = 7

//shell count
if shell_count < 0
{
    shell_count *= -1
    audio_sound_play("kick_"+string(shell_count))

    if shell_count < 7
    {
        var s;
        s = instance_create((bbox_left+bbox_right)/2, bbox_top, o_score)
        switch(shell_count)
        {
            case 1: s.scores = 100; break;
            case 2: s.scores = 200; break;
            case 3: s.scores = 500; break;
            case 4: s.scores = 1000; break;
            case 5: s.scores = 2000; break;
            case 6: s.scores = 5000; break;
            default: break;
        }
    }
    else
    {
        instance_create((bbox_left+bbox_right)/2,bbox_top,o_life)
        shell_count = 0
    }
}
