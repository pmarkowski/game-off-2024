extends Node3D

@export var camera: Camera3D
@onready var sprite_3d: Sprite3D = $Sprite3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var facing_direction := DirectionDetector.get_node_facing_relative_to_camera(camera, self)
	sprite_3d.flip_h = false
	match facing_direction:
		DirectionDetector.FacingDirection.BACK:
			sprite_3d.frame = 18
		DirectionDetector.FacingDirection.BACK_LEFT:
			sprite_3d.frame = 17
		DirectionDetector.FacingDirection.LEFT:
			sprite_3d.frame = 10
		DirectionDetector.FacingDirection.FRONT_LEFT:
			sprite_3d.frame = 4
		DirectionDetector.FacingDirection.FRONT_RIGHT:
			sprite_3d.frame = 4
			sprite_3d.flip_h = true
		DirectionDetector.FacingDirection.RIGHT:
			sprite_3d.frame = 10
			sprite_3d.flip_h = true
		DirectionDetector.FacingDirection.BACK_RIGHT:
			sprite_3d.frame = 17
			sprite_3d.flip_h = true
		_:
			sprite_3d.frame = 0
