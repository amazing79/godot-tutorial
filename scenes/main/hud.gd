extends Control


func _ready() -> void:
	update_level_indicator()


func update_hp_bar(new_value:int) -> void:
	$HitPoints/HitPointsBar.value = new_value


func update_level_indicator() -> void:
	$Level/CurrentLevel.text = str(PlayerData.level)
