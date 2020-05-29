extends Area2D


export (PackedScene) var projectile
export(AudioStreamSample) var shoot_audio  #perque el enemy pugui emetre dos sons (shoot & explosion)
export(AudioStreamSample) var explosion

onready var timer = $Timer
onready var collision = $CollisionShape2D  #perque quan mori un enemic no morin tots sino el disparat
onready var audio = $Audio

export var speed = 50  #velocitat en que es mou l'enemic
export var health = 30  #vida de l'enemic

var dead = false  #fals perque no es mori abans de la funció
var can_shoot = true

signal was_defeated

func _ready():
	audio.stream = shoot_audio  #el so s'emet cada vegada que dispara

func _process(delta):
	if can_shoot:
		_shoot()


func _shoot():
	if dead:
		return
	var new_projectile = projectile.instance()
	new_projectile.position = global_position  #POSICIÓ del projectil és igual a la posició de la nau de l'enemic - surt d'allà
	get_tree().get_root().add_child(new_projectile)  #dos tipus de positions 1.postiton (local) 2.global. L'enemic es un child d'info, si posem position = globa sera una position local - set the parent of the projectile to be the root of the game
	can_shoot = false #perque l'enemic no dispari continuament, seguit
	timer.start()  #el timer, on hi ha posat l'interval entre trets
	audio.play()  #so quan dispara



func _add_damage(damage):
	health -= damage  #redueix la vida segons el damage rebut
	if health <= 0:
		dead = true  #true perque mori quan la vida sigui igual o menys que 0.
		collision.queue_free()
		hide()   #amagar l'enemic mort del joc
		emit_signal("was_defeated")
		audio.stream = explosion  #auido explosió quan mor
		audio.play()


func _on_Timer_timeout():
	can_shoot = true
