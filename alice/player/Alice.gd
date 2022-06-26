extends Node


const SIZE_NORMAL := 1.0
const SIZE_LARGE := 3.0
const SIZE_SMALL := 0.3


var _current_size := 1.0
var _target_size := 1.0

onready var _pickup_left : Function_Pickup = $"../LeftHandController/Function_Pickup"
onready var _pickup_right : Function_Pickup = $"../RightHandController/Function_Pickup"
onready var _body : PlayerBody = $"../PlayerBody"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func size_player(var target: float):
	# Skip if already at (or sizing to) target
	if target == _target_size:
		return

	# Set the target size
	_target_size = target
	
	# Ensure player isn't holding anything
	_pickup_left.drop_object()
	_pickup_right.drop_object()

	# TODO: Disable pickup
	
	# Resize the player
	$Tween.stop_all()
	$Tween.interpolate_method(
		self, 
		"_on_size_player",
		_current_size,
		target,
		2.0,
		1)
	$Tween.start()

func _on_size_player(var size: float):
	# Update current size
	_current_size = size

	# Adjust the world scale
	ARVRServer.world_scale = size
	_body.player_radius = 0.3 * size
	_body.player_head_height = 0.1 * size
	_body.player_height_min = 1.0 * size
	_body.player_height_max = 2.2 * size

func _on_size_completed():
	# TODO: Enable pickup
	pass

func _on_Function_Pickup_has_picked_up(what: XRToolsPickable):
	if what.is_in_group("player_grow"):
		#what.drop_and_free()
		size_player(SIZE_LARGE)
	elif what.is_in_group("player_shrink"):
		#what.drop_and_free()
		size_player(SIZE_SMALL)
	elif what.is_in_group("player_normal"):
		#what.drop_and_free()
		size_player(SIZE_NORMAL)

func _on_AreaDetect_area_entered(area: Area):
	if area.is_in_group("player_grow"):
		size_player(SIZE_LARGE)
	elif area.is_in_group("player_shrink"):
		size_player(SIZE_SMALL)
	elif area.is_in_group("player_normal"):
		size_player(SIZE_NORMAL)
