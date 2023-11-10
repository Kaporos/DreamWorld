extends StaticBody2D

var appeared = false;
var player;
var rng = RandomNumberGenerator.new()
func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
func _on_visible_on_screen_notifier_2d_screen_entered():
	appeared = true;


func _on_visible_on_screen_notifier_2d_screen_exited():
	if appeared:
		position.y += (player.position.y - position.y - rng.randf_range(0, 100.0) )
		
		print(position.y)
