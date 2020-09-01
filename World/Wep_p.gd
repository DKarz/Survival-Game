extends TextureProgress


var max_t = 100
onready var ico = $Wep_p

func on_health_updated(value):
	ico.value = value
