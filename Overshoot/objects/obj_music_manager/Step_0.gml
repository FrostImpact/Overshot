var _target_track_name

if (instance_exists(obj_chrono)) {
    _target_track_name = "chrono"
}

else if (instance_exists(obj_the_king)){
	_target_track_name = "king"

} else {
    _target_track_name = "bgm"
}

if (current_track_name != _target_track_name) {
	
    play_sound_scr(_target_track_name)
    current_track_name = _target_track_name
	
}