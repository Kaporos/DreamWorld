extends Node2D

signal timer_add;

func _on_area_2d_area_entered(player):
	timer_add.emit()
	queue_free()
