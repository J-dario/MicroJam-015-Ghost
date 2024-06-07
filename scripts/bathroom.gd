extends Node2D

@onready var animation_player = $AnimationPlayer

func _ready():
	if NavMan.spawn_door_tag != null:
		_on_level_spawn(NavMan.spawn_door_tag)
	if NavMan.ice == true:
		animation_player.play("ice")
	elif NavMan.water == true:
		animation_player.play("water")
		
func _on_level_spawn(destination_tag: String):
	var door_path = "Doors/Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavMan.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)

var object = null
var player = null

func _on_bath_body_entered(body):
	object = "tub"
	player = body

func _on_bath_body_exited(body):
	object = null
	
var water = false

func _on_player_interact_signal():
	if object == "tub":
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/bathroom.dialogue"), "start")
		
		if water == false:
			animation_player.play("water")
			NavMan.water = true
			water = true
		elif water == true and NavMan.returnProperty() == "Ice":
			animation_player.play("ice")
			NavMan.ice = true
		
# add global variabl;es to handle toggles in _ready functions
