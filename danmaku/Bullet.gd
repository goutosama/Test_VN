extends Node2D

const SPEED_MIN = 20
const SPEED_MAX = 80

const bullet_image = preload("res://danmaku/BulletSprite.tres")
const bullet_propsRes: Resource = preload("res://danmaku/BulletPropResourse.tres")

export var path2dPath: NodePath #Path2D allows you to place Curve2d, BUT ROTATION WILL BE IGNORED
onready var path := get_node(path2dPath) as Path2D 
# Due to how Curve2D works (just as curve with baked points between real points), 
# we can't make normals with those baked points, so every bullet's direction will
# be determined by its previous and next point normal vector, so first and last points will not create bullets

export(Array, Resource) var ArrayOfPoints 
# 2d array, each array inside are settings for points angle(rad), delay and speed

var bullets = []
var shape

class Bullet:
	var position = Vector2()
	var speed = 1.0
	# The body is stored as a RID, which is an "opaque" way to access resources.
	# With large amounts of objects (thousands or more), it can be significantly
	# faster to use RIDs compared to a high-level approach.
	var body = RID()


func _ready():
	print(path.curve.get_point_count())
	for _i in path.curve.get_point_count():
		print(path.curve.get_point_position(_i))

	shape = Physics2DServer.circle_shape_create()
	# Set the collision shape's radius for each bullet in pixels.
	Physics2DServer.shape_set_data(shape, 8)

	for _i in path.curve.get_point_count():
		var bullet = Bullet.new()

		# Give each bullet its own speed.
		bullet.speed = rand_range(SPEED_MIN, SPEED_MAX)
		bullet.body = Physics2DServer.body_create()

		Physics2DServer.body_set_space(bullet.body, get_world_2d().get_space())
		Physics2DServer.body_add_shape(bullet.body, shape)
		# Don't make bullets check collision with other bullets to improve performance.
		# Their collision mask is still configured to the default value, which allows
		# bullets to detect collisions with the player.
		Physics2DServer.body_set_collision_layer(bullet.body, 0)

		# Place bullets randomly on the viewport and move bullets outside the
		# play area so that they fade in nicely.
		bullet.position = Vector2(path.curve.get_point_position(_i) + path.position)
		
		var transform2d = Transform2D()
		transform2d.origin = bullet.position
		Physics2DServer.body_set_state(bullet.body, Physics2DServer.BODY_STATE_TRANSFORM, transform2d)

		bullets.push_back(bullet)


func _process(_delta):
	# Order the CanvasItem to update every frame.
	update()

var delays: Array 
func _physics_process(delta):
	for _i in path.curve.get_point_count():
		delays[_i] = 0 
		if delays[_i] > ArrayOfPoints[_i].delay:
			var bullet = Bullet.new()

			# Give each bullet its own speed.
			bullet.speed = ArrayOfPoints[_i].speed
			bullet.body = Physics2DServer.body_create()

			Physics2DServer.body_set_space(bullet.body, get_world_2d().get_space())
			Physics2DServer.body_add_shape(bullet.body, shape)
			# Don't make bullets check collision with other bullets to improve performance.
			# Their collision mask is still configured to the default value, which allows
			# bullets to detect collisions with the player.
			Physics2DServer.body_set_collision_layer(bullet.body, 0)

			# Place bullets randomly on the viewport and move bullets outside the
			# play area so that they fade in nicely.
			bullet.position = Vector2(path.curve.get_point_position(_i) + path.position)
			
			var transform2d = Transform2D()
			transform2d.origin = bullet.position
			Physics2DServer.body_set_state(bullet.body, Physics2DServer.BODY_STATE_TRANSFORM, transform2d)

			bullets.push_back(bullet)
			delays[_i] = 0
		else:
			delays[_i] += 1

	var offset = get_viewport_rect().size.x + 16
	var transform2d = Transform2D()
	for bullet in bullets:
		#bullet.position.y += bullet.speed * delta

		if bullet.position.x < -16:
			# The bullet has left the screen; move it back to the right.
			bullet.position.x = offset

		transform2d.origin = bullet.position

		Physics2DServer.body_set_state(bullet.body, Physics2DServer.BODY_STATE_TRANSFORM, transform2d)


# Instead of drawing each bullet individually in a script attached to each bullet,
# we are drawing *all* the bullets at once here.
var frameCounter = 0
func _draw():
	var offset = -bullet_image.get_frame("default", frameCounter).get_size() * 0.5
	for bullet in bullets:
		draw_texture(bullet_image.get_frame("default", frameCounter), bullet.position + offset)
	frameCounter += 1
	if frameCounter >= bullet_image.get_frame_count("default"):
		frameCounter = 0

# Perform cleanup operations (required to exit without error messages in the console).
func _exit_tree():
	for bullet in bullets:
		Physics2DServer.free_rid(bullet.body)

	Physics2DServer.free_rid(shape)
	bullets.clear()
