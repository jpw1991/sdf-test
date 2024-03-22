extends MeshInstance3D


@export var move_to : Vector3

@onready var start_position = position
@onready var end_position = position + Vector3.FORWARD*25
var speed = 1.0
var direction := 1.0

@onready var vt = $"../VoxelLodTerrain".get_voxel_tool()

func _physics_process(delta: float) -> void:
	var t = (delta * 0.4) * direction
	position = position.lerp(end_position, t)
	
	if direction > 0 and position.distance_to(end_position) < 1:
		direction = -1
	elif direction < 0 and position.distance_to(start_position) < 1:
		direction = 1
	
	vt.channel = VoxelBuffer.CHANNEL_SDF
	var sdf = vt.get_voxel(position)
	$Camera3D/Label.text = "sdf = %d" % sdf
