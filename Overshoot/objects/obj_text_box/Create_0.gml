// States
enum TB_STATE {
    IDLE,
    TYPING,
    WAITING
}

box_visible = false
state = TB_STATE.IDLE

text_queue = ds_queue_create()

text_full    = ""   
text_display = ""   
char_index   = 0

type_timer = 0
type_speed = 5

type_sound = noone 

advance_key = vk_space

text_x_offset = 24
text_y_offset = 20

box_scale_x   = 1
box_min_scale = 1
box_max_width = display_get_gui_width() * 0.9