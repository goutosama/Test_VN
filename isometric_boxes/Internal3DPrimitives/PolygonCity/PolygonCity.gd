extends Spatial

export (NoiseTexture) var texture
export (float) var between = 0.5
export (float) var base_height = 0
export (float) var scale_height = 1

func _process(_delta):
	$MultiMeshInstance.texture = texture
	$MultiMeshInstance.between = between
	$MultiMeshInstance.base_height = base_height
	$MultiMeshInstance.scale_height = scale_height
