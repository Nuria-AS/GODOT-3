extends Area2D

export var speed = 450   #velocitat en que baixa el projectil
export var health = 10   #damage que proboca al player

func _ready():
	connect("body_entered", self, "_on_area_entered")
	
func _process(delta):
	position.y += speed * delta
	if position.y > 2000:
		queue_free()





func _on_area_entered(area):
	if area.name == "Player":
		area.add_health()
		queue_free()
