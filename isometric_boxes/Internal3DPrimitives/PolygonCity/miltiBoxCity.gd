extends MultiMeshInstance

export (NoiseTexture) var texture
export (float) var between = 0.5
export (float) var base_height = 0
export (float) var scale_height = 1

func _process(delta):
	self.multimesh.instance_count = texture.width * texture.height
	for x in range(texture.width):
		for y in range(texture.height):
			self.multimesh.set_instance_transform(y * texture.width + x, Transform(Vector3(1,0,0), Vector3(0,base_height+ (texture.get_noise().get_noise_2d(x, y)+1)/2 * scale_height,0), Vector3(0,0,1), Vector3(between * x, base_height, -between * y)))
