if base_speed_set == false {
    target_base_speed = speed / max(obj_game_manager.game_speed, 0.01)
    current_base_speed = target_base_speed * 1.6
    base_speed_set = true
}

current_base_speed = lerp(current_base_speed, target_base_speed, 0.2)

speed = current_base_speed * obj_game_manager.game_speed

var stretch_factor = speed * 0.025

image_xscale = 1 + stretch_factor
image_yscale = max(1 - (stretch_factor * 0.4), 0.2)