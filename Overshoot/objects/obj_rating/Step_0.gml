room_time = max(room_time - (1/room_speed), 0)
var _pct = (starting_time > 0) ? (room_time / starting_time) : 0

previous_rating = current_rating

if (_pct >= 0.75) {
    current_rating = 0
} else if (_pct >= 0.5) {
    current_rating = 1
} else if (_pct >= 0.25) {
    current_rating = 2
} else {
    current_rating = 3
}

image_index = current_rating

if (current_rating != previous_rating) {
    rating_scale = 1.6
    rating_angle = choose(-15, 15)
    flash_alpha = 1
}

rating_scale = lerp(rating_scale, 1, 0.15)
rating_angle = lerp(rating_angle, 0, 0.15)
flash_alpha = lerp(flash_alpha, 0, 0.1)

if (popup_timer > 0) popup_timer -= 1
timer_scale = lerp(timer_scale, 1, 0.2)