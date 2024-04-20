shader_type spatial;


//positive depth moves toward the camera in world units
uniform float depth_offset = 0.0;


//offset object by world coordinates
//towards the camera. VERTEX version

void vertex() {
	//model(local,object) to world(global) vertex position set to world_position
	vec3 world_position = vec4(WORLD_MATRIX * vec4(VERTEX,1)).xyz;
	//set direction vector from vertex to camera in world space
	vec3 dir2cam  = normalize(CAMERA_MATRIX[3].xyz - world_position);
	//offset depth by world(global) units.
	world_position += dir2cam * depth_offset;
	//transform world_position back to model(local, object) space and set vertex position.
	VERTEX = vec4(inverse(WORLD_MATRIX) * vec4(world_position,1)).xyz;
}