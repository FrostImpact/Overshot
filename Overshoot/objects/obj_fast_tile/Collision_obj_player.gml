var _drag = 1.15

with (other) {
    xspeed *= _drag
    yspeed *= _drag
}


part_particles_create(global.p_sys, x, y, global.p_trail, 15);
