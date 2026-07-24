room_time = max(room_time - (1/room_speed), 0)

var _pct = (starting_time > 0) ? (room_time / starting_time) : 0
if (_pct >= 0.75) {
    image_index = 0
} else if (_pct >= 0.5) {
    image_index = 1
} else if (_pct >= 0.25) {
    image_index = 2
} else {
    image_index = 3
}

if (popup_timer > 0) popup_timer -= 1

timer_scale = lerp(timer_scale, 1, 0.2)