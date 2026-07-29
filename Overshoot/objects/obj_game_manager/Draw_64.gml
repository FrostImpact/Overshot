if (global.paused == true) {

    var _gui_center_x = display_get_gui_width() / 2;
    var _gui_center_y = display_get_gui_height() / 2;
    
    draw_sprite(spr_pause_icon, 0, _gui_center_x, _gui_center_y);
}