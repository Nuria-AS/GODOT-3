extends Area2D

export var speed = 450   #velocitat en que dispara l'enemic
export var damage = 10   #damage que proboca al player

func _ready():
	connect("body_entered", self, "_on_area_entered")
	
func _process(delta):
	position.y += speed * delta
	if position.y > 2000:
		queue_free()





func _on_area_entered(area):
	if area.name == "Player":
		area.add_damage(damage)
		queue_free()
