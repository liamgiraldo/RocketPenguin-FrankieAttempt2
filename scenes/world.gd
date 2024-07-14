extends Node2D
@onready var tileMap = $TileMap
var crop_layer = 3
var tile_map_source_id = 19;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func handle_seed(tile_map_pos, level, atlas_coord, final_seed_level):
	tileMap.set_cell(crop_layer, tile_map_pos, tile_map_source_id, atlas_coord)
	
	await get_tree().create_timer(2.0).timeout
	
	if(level == final_seed_level):
		return
	else:
		var new_atlas: Vector2i = Vector2i(atlas_coord.x - 1, atlas_coord.y)
		handle_seed(tile_map_pos, level + 1, new_atlas, final_seed_level)
