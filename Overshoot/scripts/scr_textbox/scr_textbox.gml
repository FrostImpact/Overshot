function textbox_say(_text) {
	
	show_debug_message("textbox_say called")
	
	
    if (!instance_exists(obj_text_box)) {
        instance_create_layer(0, 0, "Instances", obj_text_box)
    }
    if (is_array(_text)) {
        for (var i = 0; i < array_length(_text); i++) {
            ds_queue_enqueue(obj_text_box.text_queue, _text[i])
        }
    } else {
        ds_queue_enqueue(obj_text_box.text_queue, _text)
    }
    if (obj_text_box.state == TB_STATE.IDLE) {
        obj_text_box.box_visible = true
        textbox_next_page()
    }
}

function textbox_next_page() {
    if (!instance_exists(obj_text_box)) return

    if (!ds_queue_empty(obj_text_box.text_queue)) {

        obj_text_box.text_full    = ds_queue_dequeue(obj_text_box.text_queue)
        obj_text_box.text_display = ""
        obj_text_box.char_index   = 0
        obj_text_box.type_timer   = 0
        obj_text_box.state        = TB_STATE.TYPING
        obj_text_box.box_visible  = true

        var _base_w   = sprite_get_width(spr_text_box)
        var _padding  = obj_text_box.text_x_offset * 2
        var _text_w   = string_width(obj_text_box.text_full)
        var _needed_w = _text_w + _padding

        var _scale = _needed_w / _base_w
        _scale = max(_scale, obj_text_box.box_min_scale)

        var _max_scale = obj_text_box.box_max_width / _base_w
        _scale = min(_scale, _max_scale)

        obj_text_box.box_scale_x = _scale

    } else {

        obj_text_box.state       = TB_STATE.IDLE
        obj_text_box.box_visible = false

    }
}

function textbox_advance() {
    if (!instance_exists(obj_text_box)) return

    if (obj_text_box.state == TB_STATE.TYPING) {

        obj_text_box.text_display = obj_text_box.text_full
        obj_text_box.char_index   = string_length(obj_text_box.text_full)
        obj_text_box.state        = TB_STATE.WAITING

    } else if (obj_text_box.state == TB_STATE.WAITING) {
        textbox_next_page()
    }
}

/// @function textbox_is_active()
function textbox_is_active() {
    return instance_exists(obj_text_box) && obj_text_box.box_visible
}