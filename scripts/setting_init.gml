//setting init()
if !file_exists(global.setting_file)
    setting_save()
else
    setting_apply()
