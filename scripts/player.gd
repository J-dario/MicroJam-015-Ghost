extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
var property = "Base"

signal interactSignal

const SPEED = 200
const accel = 100

func _ready():
	NavMan.on_trigger_player_spawn.connect(_on_spawn)

func _on_spawn(position: Vector2, direction: String):
	global_position = position
	property = NavMan.returnProperty()

func changeProperty(newProp: String):
	property = newProp

var input_vector: Vector2 = Vector2.ZERO

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		emit_signal("interactSignal")
	
	var x_axis: float = Input.get_axis("move_left", "move_right")
	var y_axis: float = Input.get_axis("move_up", "move_down")
	if x_axis:
		input_vector = x_axis * Vector2.RIGHT
	elif y_axis:
		input_vector = y_axis * Vector2.DOWN
	else:
		input_vector = Vector2.ZERO
	if property != NavMan.property:
		property = NavMan.property

func _physics_process(delta):
	if input_vector.length() > 0:
		velocity = input_vector * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
	#var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")	
	#velocity.x = move_toward(velocity.x, SPEED*direction.x, accel)
	#velocity.y = move_toward(velocity.y, SPEED*direction.y, accel)
	
	if velocity.x == 0 and velocity.y == 0:
		animated_sprite_2d.play(property + "Idle")
	elif velocity.y < 0:
		animated_sprite_2d.play(property +"WalkU")
	elif velocity.y > 0:
		animated_sprite_2d.play(property + "WalkF")
	elif velocity.x > 0:
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play(property +"WalkS")
	elif velocity.x < 0:
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play(property +"WalkS")
		
	move_and_slide()
