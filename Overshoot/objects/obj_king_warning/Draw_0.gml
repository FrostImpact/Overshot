//leap attack indicator, DONT USE THIS OBJECT FOR INDICATOR JUST USE DRAW IN OBJ_KING

var alpha = (dsin(current_time * 1.5) + 1) * 0.4 + 0.2; 
draw_set_color(c_red);
draw_set_alpha(alpha);
draw_circle(x, y, radius, false);
draw_set_alpha(1);