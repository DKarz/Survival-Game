extends TextureProgress


var max_health = 100
var health = max_health
onready var health_bar = $HealthBAR

func on_health_updated(health):
	health_bar.value = health
