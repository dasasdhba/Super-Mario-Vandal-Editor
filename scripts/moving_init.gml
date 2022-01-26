//moving_init()
//init for moving block
physics_init()

gravity_place = false
gravity_state = -1
gravity_a = 0.2
gravity_d = 0.2
gravity_a_water = 0.2
gravity_d_water = 0.2

move_place = false

moving_state = 0 // = 0: static, = 1: moving, = 2: falling
velocity = 2 // velocity setting by direction turn
moving_v = 0 // the velocity of moving
moving_a = 0.2 // the acceleration of gradual turning
stand_check = 0 // = 0: move at start, = 1: move when Mario stands on
fall_check = 0 // = 0: never fall, = 1: fall when Mario stands on
reverse_turn = 1 // = 0: stop, = 1: turn, = 2: turn gradually
direction_turn = 2 // = 0: stop, = 1: turn, = 2: turn gradually

reverse = false // reverse state

turn_state = 0 // = 1: turn gradually
turn_v = 0 // the target velocity of turning
turn_dir = 0 // the target direction of turning

moving_detect = false // detect setting at start
