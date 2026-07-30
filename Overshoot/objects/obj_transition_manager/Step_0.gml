if alpha < 1 {
    alpha += fade_speed
    var _move = slide_amount * fade_speed
    
    with (all) {
        if id != other.id {
            image_alpha = other.alpha
            y -= _move
        }
    }
}