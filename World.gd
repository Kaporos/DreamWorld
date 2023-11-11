extends Node2D
@export var p_scene: PackedScene;
var rng = RandomNumberGenerator.new()
@export var nbr = 4;
@export var sleep_time = 10;
@export var timerObj: PackedScene;

func _ready():
	$Timer.wait_time = sleep_time
	$Timer.start()
	$Timer.connect("timeout", dead)
	$TimerTimer.start()

func dead():
	$AudioStreamPlayer.playing = true
	get_tree().get_nodes_in_group("player")[0].set_physics_process(false)
	get_tree().get_nodes_in_group("go")[0].visible = true
	$Timer.stop()
	$TimerTimer.stop()

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
		player.velocity.y = 0
		dead()
		return
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
	_ready()
	

func adding_time():
	var left = $Timer.time_left
	$Timer.stop()
	$Timer.start( left + 5)
func _on_timer_timer_timeout():
	var player = get_tree().get_nodes_in_group("player")[0]
	var t = timerObj.instantiate()
	t.connect("timer_add", adding_time)
	add_child(t)
	var width = get_viewport().get_visible_rect().size.x
	t.global_position.x = rng.randf_range(0, width-20)
	t.global_position.y = rng.randf_range(player.global_position.y-100, player.global_position.y-300)
	
	
	
