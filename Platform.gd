extends StaticBody2D

var appeared = false;
var marker;
var rng = RandomNumberGenerator.new()
func _ready():
	var player = get_tree().get_nodes_in_group("player")[0]
	marker = player.get_node("Marker")
func _process(_delta):
	if global_position.y > marker.global_position.y:
		queue_free()
