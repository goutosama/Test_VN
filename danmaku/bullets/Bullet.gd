extends Node2D

const bullet_image = preload("res://danmaku/bullets/BulletSprite.tres")
const bullet_propsRes: Resource = preload("res://danmaku/bullets/BulletPropResourse.tres")

export var path2dPath: NodePath 
#Path2D allows you to place Curve2d, BUT ROTATION WILL BE IGNORED
onready var path := get_node(path2dPath) as Path2D 
# Due to how Curve2D works (just as curve with baked points between real points), 
# we can't make normals with those baked points, so every bullet's direction will
# be determined by its previous and next point normal vector, 
# so first and last points will not create bullets

export(Array, Vector3) var ArrayOfPoints 
# 2d array, each array inside are settings for points angle(radians), delay and speed
# first and last element of array will be ignored

# Angle rotates vector obviously (use radian circle to get the angle you want)
# Delay stops bullet from appearing for a period of time (seconds)
# Speed is basically speed of the bullet and it is multiplied by 10 internally for each bullet, 
# 	so that 1 is a very slow speed for a bullet and the more you add, the faster it gets  

export(float) var Scale = 1.0
# by default Scale = 1 bullets are 8 pixels in radius which is too small

export(int) var AnimSlowness = 4
# sounds crazy i know, but this number defines delay in frames between next animation frame and current

var bullets = []
var shape
var delays = []

class Bullet:
	var position = Vector2()
	var speed = 1.0
	var direction = Vector2()
	var visible = false
	var delay = 0
	var currFrame = 0
	var offscreen = false
	# The body is stored as a RID, which is an "opaque" way to access resources.
	# With large amounts of objects (thousands or more), it can be significantly
	# faster to use RIDs compared to a high-level approach.
	var body = RID()



func _ready():
	delays.resize(path.curve.get_point_count())

	shape = Physics2DServer.circle_shape_create()
	# Set the collision shape's radius for each bullet in pixels.
	Physics2DServer.shape_set_data(shape, 8 * Scale)
	var transform2d = Transform2D()

	for _i in range(1, path.curve.get_point_count() - 1):
		var bullet = Bullet.new()

		# Give each bullet its own speed.
		bullet.speed = ArrayOfPoints[_i].x * 10
		var between = path.curve.get_point_position(_i - 1) - path.curve.get_point_position(_i + 1)
		print(Vector2(between.y, -between.x).normalized())
		var direction = Vector2(cos(ArrayOfPoints[_i].z), sin(ArrayOfPoints[_i].z))
		bullet.direction = Vector2(between.y * direction.x - (-between.x) * direction.y, between.y * direction.y + (-between.x) * direction.x).normalized()

		bullet.delay = ArrayOfPoints[_i].y
		bullet.body = Physics2DServer.body_create()
		Physics2DServer.body_set_space(bullet.body, get_world_2d().get_space())
		Physics2DServer.body_add_shape(bullet.body, shape)
		# Don't make bullets check collision with other bullets to improve performance.
		# Their collision mask is still configured to the default value, which allows
		# bullets to detect collisions with the player.
		Physics2DServer.body_set_collision_layer(bullet.body, 5)
		Physics2DServer.body_set_collision_mask(bullet.body, 0)
		
		# Place bullets randomly on the viewport and move bullets outside the
		# play area so that they fade in nicely.
		bullet.position = Vector2(path.curve.get_point_position(_i) + path.position)
		
		transform2d.origin = bullet.position

		Physics2DServer.body_set_state(bullet.body, Physics2DServer.BODY_STATE_TRANSFORM, transform2d)
		bullets.push_back(bullet)


func _process(_delta):
	# Order the CanvasItem to update every frame.
	update()

var timer = 0
var offscreen_bullets = 0
func _physics_process(delta):
	timer += delta
	var transform2d = Transform2D()
	for bullet in bullets:
		if bullet.delay < timer:
			bullet.visible = true
		
		if bullet.visible:
			bullet.currFrame += 1
			if bullet.currFrame >= bullet_image.get_frame_count("default") * AnimSlowness:
				bullet.currFrame = 0
			bullet.position.x += bullet.speed * delta *  bullet.direction.x
			bullet.position.y += bullet.speed * delta *  bullet.direction.y

			if bullet.position.x > get_viewport_rect().size.x || bullet.position.x < 0 || bullet.position.y < 0 || bullet.position.y > get_viewport_rect().size.y:
				# The bullet has left the screen; count it
				if !(bullet.offscreen):
					bullet.offscreen = true
					offscreen_bullets += 1
			
			# if all of them are, you should kill yourself NOW
			if offscreen_bullets == path.curve.get_point_count() - 2:

				queue_free()

			transform2d.origin = bullet.position

			Physics2DServer.body_set_state(bullet.body, Physics2DServer.BODY_STATE_TRANSFORM, transform2d)

# Instead of drawing each bullet individually in a script attached to each bullet,
# we are drawing *all* the bullets at once here.
func _draw():
	var offset = -bullet_image.get_frame("default", 0).get_size() * 0.5
	for bullet in bullets:
		if bullet.visible:
			# we need to compensate scaling by reducing position vector with itself (for whatever reason)
			draw_set_transform(-bullet.position - offset, 0.0, Vector2(Scale, Scale))
			draw_texture(bullet_image.get_frame("default", bullet.currFrame/AnimSlowness), bullet.position + offset)

# Perform cleanup operations (required to exit without error messages in the console).
func _exit_tree():
	for bullet in bullets:
		Physics2DServer.free_rid(bullet.body)

	Physics2DServer.free_rid(shape)
	bullets.clear()

func _on_Player_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	pass # Replace with function body.
