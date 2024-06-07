extends Node2D

func _ready():
	if NavMan.spawn_door_tag != null:
		_on_level_spawn(NavMan.spawn_door_tag)
		if NavMan.open == true:
			animation_player.play("open")
		
func _on_level_spawn(destination_tag: String):
	var door_path = "Doors/Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavMan.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)

var object = null
var player = null

func _on_barrier_body_entered(body):
	object = "barrier"
	player = body

func _on_barrier_body_exited(body):
	object = null
	

@onready var animation_player = $AnimationPlayer

func _on_player_interact_signal():
	if object == "barrier":
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/hallway.dialogue"), "start")
		
		if player.property == "Fire":
			animation_player.play("open")
		
# add global variabl;es to handle toggles in _ready functions
