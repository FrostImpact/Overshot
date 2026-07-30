if (!triggered) {
    triggered = true;
    
    with (other) {
        visible = false;
    }
    
   
    instance_create_depth(0, 0, -9999, obj_shatter);
	
}