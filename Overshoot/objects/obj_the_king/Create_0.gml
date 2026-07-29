// Inherit the parent event
event_inherited();

// Base State & Timers
state = 0;
timer = 60;
targ_x = 0;
targ_y = 0;

//Health & Stats 
enemy_hp = 800;
enemy_max_hp = 800;
phase = 1;

target_hp = enemy_hp;
display_hp = enemy_hp;

//Cooldown Trackers
leap_cooldown = 0;
laser_cooldown = 0;

dash_cooldown = 0;
dash_dir = 0;

//Visual Transform Variables
visual_xscale = 1;
visual_yscale = 1;
base_scale = 1;
visual_angle = 0;

laser_start_angle = 0;
laser_sweep_progress = 0;
laser_length = 600;

image_blend = c_orange;

z_offset = 0;
z_spd = 0;
dash_curr_spd = 0;


