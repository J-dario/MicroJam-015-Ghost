extends Node2D
@onready var end = $End
func _ready():
	if NavMan.spawn_door_tag != null:
		_on_level_spawn(NavMan.spawn_door_tag)
		
func _on_level_spawn(destination_tag: String):
	var door_path = "Doors/Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavMan.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)

var object = null
var player = null

func _on_fire_body_entered(body):
	object = "fire"
	player = body
	
func _on_fire_body_exited(body):
	object = null

func _on_death_body_entered(body):
	object = "death"
	player = body

func _on_death_body_exited(body):
	object = null
	if NavMan.stay == true:
		end.play("EndCut")
	
func _on_player_interact_signal():
	if object == "fire":
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main_room.dialogue"), "Fire")
		updatePlayer()
		
	elif object == "death":
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main_room.dialogue"), "Death")
		updatePlayer()

func updatePlayer():
	player.changeProperty(NavMan.returnProperty())
