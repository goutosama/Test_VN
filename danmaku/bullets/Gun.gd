extends Node2D

const bullet_image = preload("res://danmaku/bullets/BulletSprite.tres")
const bullet_propsRes: Resource = preload("res://danmaku/bullets/BulletPropResourse.tres")


onready var Player = get_parent().get_node("Player")
export(Array) var game_field = [760, 716, 0, 0] # Size of the game window.

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
export var speed : int = 5


class Bullet:
	var position = Vector2()
	var speed = 4.0
	var direction = Vector2()
	var currFrame = 0
	var offscreen = false
	# The body is stored as a RID, which is an "opaque" way to access resources.
	# With large amounts of objects (thousands or more), it can be significantly
	# faster to use RIDs compared to a high-level approach.
	var body = RID()



func _ready():
	shape = Physics2DServer.circle_shape_create()
	# Set the collision shape's radius for each bullet in pixels.
	Physics2DServer.shape_set_data(shape, 8 * Scale)

func _process(_delta):
	# Order the CanvasItem to update every frame.
	update()


func _input(event):
	if Input.is_action_just_pressed("Fire"):
		var transform2d = Transform2D()
		var bullet = Bullet.new()

		# Give each bullet its own speed.
		bullet.speed = speed * 100
		
		bullet.direction = Vector2.UP
		bullet.body = Physics2DServer.body_create()
		Physics2DServer.body_set_space(bullet.body, get_world_2d().get_space())
		Physics2DServer.body_add_shape(bullet.body, shape)
		# Don't make bullets check collision with other bullets to improve performance.
		# Their collision mask is still configured to the default value, which allows
		# bullets to detect collisions with the player.
		Physics2DServer.body_set_collision_layer(bullet.body, 5)
		Physics2DServer.body_set_collision_mask(bullet.body, 2) # 2 is enemy collision
		
		# Place bullets randomly on the viewport and move bullets outside the
		# play area so that they fade in nicely.
		bullet.position = Player.position + Vector2(0,-40)
		
		transform2d.origin = bullet.position

		Physics2DServer.body_set_state(bullet.body, Physics2DServer.BODY_STATE_TRANSFORM, transform2d)
		bullets.push_back(bullet)
		

var timer = 0
var offscreen_bullets = 0
func _physics_process(delta):
	timer += delta
	var transform2d = Transform2D()
	for bullet in bullets:
		bullet.position.x += bullet.speed * delta *  bullet.direction.x
		bullet.position.y += bullet.speed * delta *  bullet.direction.y
		bullet.currFrame += 1
		if bullet.currFrame >= bullet_image.get_frame_count("default") * AnimSlowness:
			bullet.currFrame = 0
		if bullet.position.x > game_field[0] || bullet.position.x < game_field[2] || bullet.position.y < game_field[3] || bullet.position.y > game_field[1]:
			# The bullet has left the screen; KILL IT
			bullets.erase(bullet)

		transform2d.origin = bullet.position

		Physics2DServer.body_set_state(bullet.body, Physics2DServer.BODY_STATE_TRANSFORM, transform2d)

# Instead of drawing each bullet individually in a script attached to each bullet,
# we are drawing *all* the bullets at once here.
func _draw():
	var offset = -bullet_image.get_frame("default", 0).get_size() * 0.5
	for bullet in bullets:
		# we need to compensate scaling by reducing position vector with itself (for whatever reason)
		#draw_set_transform(-bullet.position - offset, 0.0, Vector2(Scale, Scale))
		draw_texture(bullet_image.get_frame("default", bullet.currFrame/AnimSlowness), bullet.position + offset)

# Perform cleanup operations (required to exit without error messages in the console).
func _exit_tree():
	for bullet in bullets:
		Physics2DServer.free_rid(bullet.body)

	Physics2DServer.free_rid(shape)
	bullets.clear()

func _on_Player_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	pass # Replace with function body.
