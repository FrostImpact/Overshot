if (global.paused == false) {
    var gm = obj_game_manager;
    var g_spd = gm.game_speed;
    
    timer -= g_spd;
    if (timer <= 0) {
        instance_destroy();
    }
}