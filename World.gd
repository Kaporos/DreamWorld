extends Node2D
@export var p_scene: PackedScene;
var rng = RandomNumberGenerator.new()
@export var nbr = 4;
func spawn_random():
	var platforms = get_tree().get_nodes_in_group("platform")
	var pt = p_scene.instantiate()
	add_child(pt)
	var width = get_viewport().get_visible_rect().size.x
	pt.global_position.y = platforms[-1].position.y - randf_range(200,275)
	pt.global_position.x = rng.randf_range(0, width-200)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var nbrA = len(get_tree().get_nodes_in_group("platform"))
	if nbrA == 0:
		var pt = p_scene.instantiate()
		add_child(pt)
		var player = get_tree().get_nodes_in_group("player")[0]
		pt.global_position.y = player.global_position.y + 100
		pt.global_position.x = player.global_position.x - 80;
		for x in range(0, nbr-1):
			spawn_random()
		return
	if nbrA < nbr:
		spawn_random()
	nbr = nbrA
	
	
