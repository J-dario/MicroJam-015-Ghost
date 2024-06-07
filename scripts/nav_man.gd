extends Node

const bedroom = preload("res://scenes/bedroom.tscn")
const bathroom = preload("res://scenes/bathroom.tscn")
const hallway = preload("res://scenes/hallway.tscn")
const main = preload("res://scenes/main_room.tscn")
const rat = preload("res://scenes/rat_room.tscn")
const kitchen = preload("res://scenes/kitchen.tscn")
const sac = preload("res://scenes/sac_room.tscn")

signal on_trigger_player_spawn

var spawn_door_tag

func go_to_level(level_tag, destinaiton_tag):
	var scene_to_load
	
	match level_tag:
		"bedroom":
			scene_to_load = bedroom
		"bathroom":
			scene_to_load = bathroom
		"hallway":
			scene_to_load = hallway
		"main":
			scene_to_load = main
		"rat":
			scene_to_load = rat
		"kitchen":
			scene_to_load = kitchen
		"sac":
			scene_to_load = sac
			
	if scene_to_load != null:
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		spawn_door_tag = destinaiton_tag

		get_tree().change_scene_to_packed(scene_to_load)

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)

var property = "Base"
var elec = false
var ice = false
var fire = false
var stay = false
var open = false
var read = false
var water = false
var leave = false

func changeProperty(newProp: String):
	property = newProp
	
func returnProperty():
	return property
