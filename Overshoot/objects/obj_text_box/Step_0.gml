if (state == TB_STATE.TYPING) {
    type_timer++
    if (type_timer >= type_speed) {
        type_timer = 0
        char_index++
        text_display = string_copy(text_full, 1, char_index)

        if (type_sound != noone) {
            var _char = string_char_at(text_full, char_index)
            if (_char != " " && _char != "") {
                audio_play_sound(type_sound, 10, false)
            }
        }

        if (char_index >= string_length(text_full)) {
            state = TB_STATE.WAITING
        }
    }
}

if (keyboard_check_pressed(advance_key)) {
    textbox_advance()
}