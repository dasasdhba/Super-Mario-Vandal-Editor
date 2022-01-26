//setting_apply()
if !file_exists(global.setting_file)
    return false;

var ini;
ini = INI_open(global.setting_file)

global.key_up = INI_read_real(ini,"control","up",global.key_up)
global.key_down = INI_read_real(ini,"control","down",global.key_down)
global.key_left = INI_read_real(ini,"control","left",global.key_left)
global.key_right = INI_read_real(ini,"control","right",global.key_right)
global.key_jump = INI_read_real(ini,"control","jump",global.key_jump)
global.key_fire = INI_read_real(ini,"control","fire",global.key_fire)
global.key_pause = INI_read_real(ini,"control","pause",global.key_pause)
global.music = INI_read_real(ini,"setting","music",global.music*100)/100.0
global.sound = INI_read_real(ini,"setting","sound",global.sound*100)/100.0
global.size = INI_read_real(ini,"setting","size",global.size*100)/100.0
global.fullscreen = INI_read_real(ini,"setting","fullscreen",global.fullscreen)
global.effect = INI_read_real(ini,"setting","effect",global.effect)

INI_close(ini)

global.music = min(max(global.music,0),1)
global.sound = min(max(global.sound,0),1)
global.size = min(max(global.size,1),2)
if global.fullscreen != 0 && global.fullscreen != 1
    global.fullscreen = 0
if global.effect != 0 && global.effect != 1
    global.effect = 1

audio_sound_set_volume_all()
audio_music_set_volume_all()
window_set_fullscreen(global.fullscreen)
window_set_size(view_wport[0]*global.size,view_hport[0]*global.size)

return true;
