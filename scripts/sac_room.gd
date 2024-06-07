extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var animation_player_2 = $AnimationPlayer2

func _ready():
	if NavMan.spawn_door_tag != null:
		_on_level_spawn(NavMan.spawn_door_tag)
	if NavMan.ice == true:
		animation_player_2.play("salltt")	
	if NavMan.fire == true:
		animation_player.play("light")
		
func _on_level_spawn(destination_tag: String):
	var door_path = "Doors/Door_" + destination_tag
	var door = get_node(door_path) as Door
	NavMan.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)

var object = null
var player = null

func _on_lec_body_entered(body):
	object = "lec"
	player = body

func _on_lec_body_exited(body):
	object = null
	
func _on_candle_body_entered(body):
	object = "candle"
	player = body

func _on_candle_body_exited(body):
	object = null

func _on_player_interact_signal():
	if object == "lec":
		if NavMan.leave == true:
			animation_player_2.play("end")
		else:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/sac.dialogue"), "lec")
			updatePlayer()
		
	if object == "candle":
		if player.property == "Fire":
			animation_player.play("light")
			NavMan.fire = true

func updatePlayer():
	player.changeProperty(NavMan.returnProperty())
