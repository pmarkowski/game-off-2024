class_name DirectionDetector

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


static func get_node_facing_relative_to_camera(camera: Camera3D, node: Node3D) -> FacingDirection:
	if not camera:
		return FacingDirection.FRONT

	var camera_front_vector := camera.global_transform.basis.z
	var character_front_vector := node.global_transform.basis.z

	var angle_in_degrees := rad_to_deg(
		camera_front_vector.signed_angle_to(character_front_vector, Vector3.UP)
	)

	# Make sure to do < and then <= to leave no 'gaps' where a facing direction is not assigned
	if angle_in_degrees <= -157.5:
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
	elif 157.5 < angle_in_degrees:
		return FacingDirection.BACK

	return FacingDirection.FRONT
