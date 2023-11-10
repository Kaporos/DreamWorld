extends Node2D


@export var platform: PackedScene;
var timer: SceneTreeTimer;

func create_timer(time) :
	get_tree().create_timer(time).connect("timeout", spawn)

func _ready():
	create_timer(0.5)

func spawn():
	var plt = platform.instantiate()
	
	
