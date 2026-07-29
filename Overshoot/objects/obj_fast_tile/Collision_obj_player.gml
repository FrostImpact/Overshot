var _drag = 1.1

with (other) {
    xspeed *= _drag
    yspeed *= _drag
}


part_particles_create(global.p_sys, x, y, global.p_trail, 15);
