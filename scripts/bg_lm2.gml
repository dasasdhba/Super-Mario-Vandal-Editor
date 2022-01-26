//bg_lm2()
background_visible[0] = 1
background_visible[1] = 1
background_visible[2] = 1
background_visible[3] = 0

background_index[0] = back_sky_lm_color
background_htiled[0] = 1
background_vtiled[0] = 0
background_xscale[0] = 1
background_yscale[0] = room_height
background_blend[0] = c_white
background_y[0] = 0
background_x[0] = 0
background_alpha[0] = 1

background_index[1] = back_sky_lm
background_htiled[1] = 1
background_vtiled[1] = 0
background_xscale[1] = 1
background_yscale[1] = (room_height+480)/960
background_blend[1] = c_white
background_x[1] = 0
background_y[1] = room_height-320*background_yscale[1]
background_alpha[1] = 1

background_index[2] = back_coral
background_htiled[2] = 1
background_vtiled[2] = 0
background_xscale[2] = 1
background_yscale[2] = 1
background_blend[2] = c_white
background_x[2] = 0
background_y[2] = room_height-160
background_alpha[2] = 1
