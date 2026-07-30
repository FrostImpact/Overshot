function play_sound_scr(sound_name) {
    switch (sound_name) {
        case "stretch":
            var _stretch_id = audio_play_sound(snd_stretch, 1, false)
            audio_sound_gain(_stretch_id, 2, 0)
            break
            
        case "release":
            audio_stop_sound(snd_stretch)
            audio_play_sound(snd_release, 1, false)
            break
            
        case "bgm":
            audio_stop_sound(snd_chrono)
			audio_stop_sound(snd_king)
            audio_play_sound(snd_background_music, 1, true)
            break
            
        case "chrono":
            audio_stop_sound(snd_background_music)
            audio_play_sound(snd_chrono, 1, true)
            break
			
		case "king":
            audio_stop_sound(snd_background_music)
            audio_play_sound(snd_king, 1, true)
            break
            
        default:
            show_debug_message("something broke")
            break
    }
}