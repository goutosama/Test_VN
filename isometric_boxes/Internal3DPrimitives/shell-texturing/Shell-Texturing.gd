extends Spatial

onready var mesh = self.multimesh

export (NoiseTexture) var noise
export (float) var shell_height = 100.0

func _process(delta):
	var shell_between_h = shell_height/mesh.instance_count
	var heightNorm = 1.0/mesh.instance_count
	for x in range(16):
		mesh.set_instance_transform(x, Transform(Basis(), Vector3(0, x * shell_between_h, 0)))
		mesh.set_instance_color(x, Color(heightNorm * x, heightNorm * x, heightNorm * x, 1))

