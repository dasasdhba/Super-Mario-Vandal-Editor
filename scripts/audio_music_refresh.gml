//audio_music_refresh()
//unload the unplaying music from the memory
var i;
for (i=0;i<ds_list_size(global.music_instance_list);i+=1)
{
    if !FMODInstanceIsPlaying(ds_list_find_value(global.music_instance_list, i))
    {
        FMODSoundFree(ds_list_find_value(global.music_id_list, i))
        ds_list_delete(global.music_id_list, i)
        ds_list_delete(global.music_instance_list, i)
        i -= 1
    }
}
