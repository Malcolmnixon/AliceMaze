extends Spatial


func _on_SnapZone_has_picked_up(what):
	if $LeftHatSnapZone.picked_up_object and $RightHatSnapZone.picked_up_object:
		_open_gate()


func _open_gate():
	$GateAnimation.play("Open")


func _on_VictoryArea_body_entered(body: PhysicsBody):
	if body.is_in_group("player_body"):
		$Player/PlayerBody.enabled = false
		$VictoryStreamPlayer.play()


func _on_VictoryStreamPlayer_finished():
	get_tree().reload_current_scene()
