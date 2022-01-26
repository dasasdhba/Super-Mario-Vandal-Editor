//bg_day_coral_parallax()
background_visible[0] = 1
background_visible[1] = 1
background_visible[2] = 1
background_visible[3] = 1

background_index[0] = back_sky_day
background_htiled[0] = 1
background_vtiled[0] = 0
background_xscale[0] = 1
background_yscale[0] = room_height/480
background_blend[0] = c_white
background_x[0] = 0
background_y[0] = 0
background_alpha[0] = 1

background_index[1] = back_coral
background_htiled[1] = 1
background_vtiled[1] = 0
background_xscale[1] = 1
background_yscale[1] = 1
background_blend[1] = c_white
background_x[1] = parallax_x(0.3)
background_y[1] = room_height-180
background_alpha[1] = 0.2

background_index[2] = back_coral
background_htiled[2] = 1
background_vtiled[2] = 0
background_xscale[2] = 1
background_yscale[2] = 1
background_blend[2] = c_white
background_x[2] = parallax_x(0.5)
background_y[2] = room_height-160
background_alpha[2] = 0.8

background_index[3] = back_coral
background_htiled[3] = 1
background_vtiled[3] = 0
background_xscale[3] = 1
background_yscale[3] = 1
background_blend[3] = c_white
background_x[3] = parallax_x(0.7)
background_y[3] = room_height-140
background_alpha[3] = 1
