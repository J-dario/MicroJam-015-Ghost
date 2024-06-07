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

func _on_rat_body_entered(body):
	object = "Rat"
	player = body

func _on_rat_body_exited(body):
	object = null

func _on_player_interact_signal():
	if object == "Rat":
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/rat.dialogue"), "start")
