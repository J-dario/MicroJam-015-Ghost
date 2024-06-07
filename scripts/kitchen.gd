extends Node2D

func _ready():
	if NavMan.spawn_door_tag != null:
		_on_level_spawn(NavMan.spawn_door_tag)

func _on_level_spawn(destination_tag: String):
	var door_path = "Doors/Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavMan.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)

var object = null
var player = null

func _on_fridge_int_body_entered(body):
	object = "fridge"
	player = body

func _on_fridge_int_body_exited(body):
	object = null

func _on_plug_int_body_entered(body):
	object = "plug"
	player = body
	
func _on_plug_int_body_exited(body):
	object = null

func _on_bowl_body_entered(body):
	object = "bowl"

func _on_bowl_body_exited(body):
	object = null
	
func _on_player_interact_signal():
	if object == "fridge":
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/kitchnen.dialogue"), "fridge")
		updatePlayer()
		
	elif object == "bowl":
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/kitchnen.dialogue"), "bowl")
		
	elif object == "plug":
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/kitchnen.dialogue"), "plug")
		updatePlayer()

func updatePlayer():
	player.changeProperty(NavMan.returnProperty())
