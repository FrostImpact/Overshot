//https://forum.gamemaker.io/index.php?threads/screen-shatter-effect-with-voronio-diagram.105463/
//lowkey stole this code

surf_spr = sprite_create_from_surface(application_surface, 0, 0, surface_get_width(application_surface), surface_get_height(application_surface), false, false, 0, 0)
tex = sprite_get_texture(surf_spr, 0)
w = surface_get_width(application_surface)
h = surface_get_height(application_surface)
cx = w / 2
cy = h / 2
timer = 120

for (var i = 0 ; i < 8 ; i += 1) {
    sx[i] = 0
    sy[i] = 0
    var dir = i * 45
    s_xspeed[i] = lengthdir_x(random_range(3, 8), dir + 22.5)
    s_yspeed[i] = lengthdir_y(random_range(3, 8), dir + 22.5) - 4
    px1[i] = cx
    py1[i] = cy
    px2[i] = cx + lengthdir_x(w * 2, dir)
    py2[i] = cy + lengthdir_y(w * 2, dir)
    px3[i] = cx + lengthdir_x(w * 2, dir + 45)
    py3[i] = cy + lengthdir_y(w * 2, dir + 45)
}