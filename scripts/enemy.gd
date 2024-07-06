extends CharacterBody2D

const SPEED = 50.0

var player: Node2D

func _ready():
	player = get_parent().get_node("Player")

func chase(delta):
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * SPEED

func _physics_process(delta):
	chase(delta)
	move_and_slide()
