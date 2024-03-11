extends Node3D

@export var projectile: PackedScene
@export var turret_range := 10.0

@onready var barrel: Node3D = $TurretBase/TurretTop
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cannon: Node3D = $TurretBase/TurretTop/Cannon
@onready var turret_base: Node3D = $TurretBase

var enemy_path: Path3D 
var target: PathFollow3D

func _physics_process(delta: float) -> void:
	target = find_best_target()
	if target:
		turret_base.look_at(target.global_position, Vector3.UP, true)

func _on_timer_timeout() -> void:
	if target == null:
		return
	var shot = projectile.instantiate()
	add_child(shot)
	animation_player.play("turret_fire")
	shot.global_position = cannon.global_position
	shot.direction = turret_base.global_transform.basis.z

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
