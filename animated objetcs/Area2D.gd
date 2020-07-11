extends Area2D


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		$Sprite/ChestAnimation.play("Box")
	elif $Sprite/ChestAnimation.play("Box") and $Sprite.frame == 3:
			$Sprite/ChestAnimation.stop()
			

func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		$Sprite.frame = 0
		$Sprite/ChestAnimation.stop()
