extends Node3D

@export var turret: PackedScene
@export var enemy_path: Path3D

func build_turrent(turret_postion: Vector3) -> void:
	var new_turret = turret.instantiate()
	add_child(new_turret)
	new_turret.global_position = turret_postion
	new_turret.enemy_path = enemy_path
