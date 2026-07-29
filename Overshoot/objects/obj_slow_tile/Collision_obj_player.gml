var _drag = 0.9

with (other) {
    xspeed *= _drag
    yspeed *= _drag
}

part_particles_create(global.p_sys, x, y, global.p_trail, 15);
