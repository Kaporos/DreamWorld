extends Node2D
@export var p_scene: PackedScene;
var rng = RandomNumberGenerator.new()
@export var nbr = 4;
@export var sleep_time = 10;

func _ready():
	$Timer.wait_time = sleep_time
	$Timer.start()
	$Timer.connect("timeout", dead)

func dead():
	get_tree().get_nodes_in_group("player")[0].set_physics_process(false)
	get_tree().get_nodes_in_group("go")[0].visible = true
func spawn_random():
	var platforms = get_tree().get_nodes_in_group("platform")
	var pt = p_scene.instantiate()
	add_child(pt)
	var width = get_viewport().get_visible_rect().size.x
	pt.global_position.y = platforms[-1].position.y - randf_range(200,275)
	pt.global_position.x = rng.randf_range(0, width-200)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player = get_tree().get_nodes_in_group("player")[0]
	if abs(player.velocity.y) > 2000:
		dead()
	get_tree().get_nodes_in_group("progress")[0].value = $Timer.time_left*100/sleep_time
	var nbrA = len(get_tree().get_nodes_in_group("platform"))
	if nbrA == 0:
		var pt = p_scene.instantiate()
		add_child(pt)
		pt.global_position.y = player.global_position.y + 100
		pt.global_position.x = player.global_position.x - 80;
		for x in range(0, nbr-1):
			spawn_random()
		return
	if nbrA < nbr:
		spawn_random()
	nbr = nbrA
	
	


func _on_button_pressed():
	var ps = get_tree().get_nodes_in_group("platform");
	for p in ps:
		p.queue_free()
	var player = get_tree().get_nodes_in_group("player")[0]
	player.set_physics_process(true)
	player.velocity.y = 0
	player.velocity.x = 0
	get_tree().get_nodes_in_group("go")[0].visible = false
	var scoreLabel =  get_tree().get_nodes_in_group("score")[0]
	scoreLabel.text = str(0)
	$Timer.start()
	
