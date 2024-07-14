extends CharacterBody2D


@onready var tilemap : TileMap = $"../TileMap"
@onready var main = $".."

const SPEED = 150.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : float
var direction2 : float
var lastdirection : float
var lastdirection2: float
var can_place_seed_custom_data = "can_have_seeds"
var ground_layer = 0
var crop_layer = 3

func _physics_process(delta):
	
	
	# Add the gravity.
	#if not is_on_floor():
		#velocity.y += gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("ui_left", "ui_right")
	if(direction != 0):
		lastdirection = direction
		lastdirection2 = 0
	direction2 = Input.get_axis("ui_up", "ui_down")
	if(direction2 != 0):
		lastdirection2 = direction2
		lastdirection = 0
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if direction2:
		velocity.y = direction2 * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
func _input(event):
	if(Input.is_action_just_pressed("space")):
		var player_pos : Vector2 = transform.get_origin()
		var player_tile_pos : Vector2i = tilemap.local_to_map(player_pos) 
		print("Player tile position: ")
		print(player_tile_pos.x)
		print(player_tile_pos.y)
		
		var player_facing_tile: Vector2i
		
		var source_id: int = 19
		var atlas_coord : Vector2i = Vector2i(9,0)
		
		player_tile_pos.x  = player_tile_pos.x + (lastdirection)
		player_facing_tile = player_tile_pos
			
		player_tile_pos.y = player_tile_pos.y + (lastdirection2)
		player_facing_tile = player_tile_pos
		
		print("Player facing tile: ")
		print(player_facing_tile.x)
		print(player_facing_tile.y)
			
		var tile_data : TileData = tilemap.get_cell_tile_data(ground_layer, player_facing_tile)
		if tile_data:
			var can_place_seeds = tile_data.get_custom_data(can_place_seed_custom_data)
			if can_place_seeds:
				tilemap.set_cell(ground_layer, player_facing_tile, source_id, atlas_coord)
				
				var corn_atlas : Vector2i = Vector2i(3,1)
				main.handle_seed(player_facing_tile, 0, corn_atlas, 2)
				
				var top_corn_atlas : Vector2i = Vector2i(3, 0)
				var player_facing_tile_up1 : Vector2i = Vector2i(player_facing_tile.x, player_facing_tile.y-1)
				main.handle_seed(player_facing_tile, 0, corn_atlas, 3)
				main.handle_seed(player_facing_tile_up1, 0, top_corn_atlas, 3)
				
		else:
			print("no tile data")
