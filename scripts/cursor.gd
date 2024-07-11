extends AnimatedSprite2D

@onready var player = $"../Player"
var perimeter_radius:float = 50
var distance:Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#get_input()
	move_weapon()

func move_weapon():
	position = get_global_mouse_position()
	#position.x = clamp(position.x, player.position.x-perimeter_radius, player.position.x+perimeter_radius)
	#position.y= clamp(position.y, player.position.y-perimeter_radius, player.position.y+perimeter_radius)
	distance = position - player.position
	if (distance.length() > 40):
		position = player.position + (distance).normalized() * 40
	rotation = 0
	look_at(get_local_mouse_position())
