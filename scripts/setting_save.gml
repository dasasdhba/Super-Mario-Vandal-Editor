//setting_save()
var ini;
ini = INI_open(global.setting_file)

INI_write(ini,"control","up",global.key_up)
INI_write(ini,"control","down",global.key_down)
INI_write(ini,"control","left",global.key_left)
INI_write(ini,"control","right",global.key_right)
INI_write(ini,"control","jump",global.key_jump)
INI_write(ini,"control","fire",global.key_fire)
INI_write(ini,"control","pause",global.key_pause)
INI_write(ini,"setting","music",global.music*100)
INI_write(ini,"setting","sound",global.sound*100)
INI_write(ini,"setting","size",global.size*100)
INI_write(ini,"setting","fullscreen",global.fullscreen)
INI_write(ini,"setting","effect",global.effect)

INI_save_file(ini,global.setting_file)
INI_close(ini)
