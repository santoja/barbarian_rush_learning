extends Node3D

@export var projectile: PackedScene
@export var turret_range := 10.0

@onready var barrel: MeshInstance3D = $TurretBase/TurretTop/Barrel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var enemy_path: Path3D 
var target: PathFollow3D

func _physics_process(delta: float) -> void:
	target = find_best_target()
	if target:
		look_at(target.global_position, Vector3.UP, true)

func _on_timer_timeout() -> void:
	if target == null:
		return
	var shot = projectile.instantiate()
	add_child(shot)
	animation_player.play("turret_fire")
	shot.global_position = barrel.global_position
	shot.direction = global_transform.basis.z

func find_best_target() -> PathFollow3D:
	var best_target = null
	var best_progres = 0
	for enemy in enemy_path.get_children():
		if not enemy is PathFollow3D:
			continue
		if global_position.distance_to(enemy.global_position) > turret_range:
			continue
		if enemy.progress > best_progres:
			best_progres = enemy.progress
			best_target = enemy
	return best_target 
