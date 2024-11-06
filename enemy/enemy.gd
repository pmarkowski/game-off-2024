extends Node3D

enum FacingDirection {
	FRONT,
	FRONT_RIGHT,
	RIGHT,
	BACK_RIGHT,
	BACK,
	BACK_LEFT,
	LEFT,
	FRONT_LEFT
}

@export var camera: Camera3D

@onready var sprite_3d: Sprite3D = $Sprite3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _get_facing_relative_to_camera(camera: Camera3D) -> FacingDirection:
	if not camera:
		return FacingDirection.FRONT

	var camera_front_vector := -camera.global_transform.basis.z
	var character_front_vector := global_transform.basis.z

	var angle_in_degrees := rad_to_deg(
		camera_front_vector.signed_angle_to(character_front_vector, Vector3.UP)
	)

	# Make sure to do < and then <= to leave no 'gaps' where a facing direction is not assigned
	if -180 < angle_in_degrees and angle_in_degrees <= -157.5:
		return FacingDirection.BACK
	elif -157.5 < angle_in_degrees and angle_in_degrees <= -112.5:
		return FacingDirection.BACK_LEFT
	elif -112.5 < angle_in_degrees and angle_in_degrees <= -67.5:
		return FacingDirection.LEFT
	elif -67.5 < angle_in_degrees and angle_in_degrees <= -22.5:
		return FacingDirection.FRONT_LEFT
	elif -22.5 < angle_in_degrees and angle_in_degrees <= 22.5:
		return FacingDirection.FRONT
	elif 22.5 < angle_in_degrees and angle_in_degrees <= 67.5:
		return FacingDirection.FRONT_RIGHT
	elif 67.5 < angle_in_degrees and angle_in_degrees <= 112.5:
		return FacingDirection.RIGHT
	elif 112.5 < angle_in_degrees and angle_in_degrees <= 157.5:
		return FacingDirection.BACK_RIGHT
	elif 157.5 < angle_in_degrees and angle_in_degrees <= 180:
		return FacingDirection.BACK

	return FacingDirection.FRONT


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var facing_direction := _get_facing_relative_to_camera(camera)
	sprite_3d.flip_h = false
	match facing_direction:
		FacingDirection.BACK:
			sprite_3d.frame = 18
		FacingDirection.BACK_LEFT:
			sprite_3d.frame = 17
		FacingDirection.LEFT:
			sprite_3d.frame = 10
		FacingDirection.FRONT_LEFT:
			sprite_3d.frame = 4
		FacingDirection.FRONT_RIGHT:
			sprite_3d.frame = 4
			sprite_3d.flip_h = true
		FacingDirection.RIGHT:
			sprite_3d.frame = 10
			sprite_3d.flip_h = true
		FacingDirection.BACK_RIGHT:
			sprite_3d.frame = 17
			sprite_3d.flip_h = true
		_:
			sprite_3d.frame = 0
