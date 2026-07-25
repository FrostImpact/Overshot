draw_set_color(c_white)

for (var i = 0 ; i < 8 ; i += 1) {
    draw_primitive_begin_texture(pr_trianglelist, tex)
    
    var nx1 = px1[i] + sx[i]
    var ny1 = py1[i] + sy[i]
    var nx2 = px2[i] + sx[i]
    var ny2 = py2[i] + sy[i]
    var nx3 = px3[i] + sx[i]
    var ny3 = py3[i] + sy[i]

    draw_vertex_texture(nx1, ny1, px1[i] / w, py1[i] / h)
    draw_vertex_texture(nx2, ny2, px2[i] / w, py2[i] / h)
    draw_vertex_texture(nx3, ny3, px3[i] / w, py3[i] / h)
    
    draw_primitive_end()
}