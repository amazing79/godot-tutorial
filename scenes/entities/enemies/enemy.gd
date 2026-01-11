extends CharacterBody2D

@export_category("Stats")
@export var hitpoints: int = 180
@export_category("Related Scene")
@export var death_scene: PackedScene

func take_damage(damage_taken:int) -> void:
	hitpoints -= damage_taken
	if hitpoints <= 0:
		death()


func death() -> void:
	var scene: Node2D = death_scene.instantiate()
	scene.position = global_position + Vector2(0.0,-32.0)
	%Effects.add_child(scene)
	queue_free()
