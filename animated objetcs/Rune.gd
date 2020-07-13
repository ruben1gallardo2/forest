extends Area2D

func _ready():
	
	
	$Tween.interpolate_property(
	$AnimatedSprite,
	'scale',
	$AnimatedSprite.scale,
	$AnimatedSprite.scale * 2,
	1,
	Tween.TRANS_QUAD,
	Tween.EASE_IN_OUT		
	)
	$Tween.interpolate_property(
	$AnimatedSprite,
	'modulate',
	Color(1,1,1,1),
	Color(1,1,1,0),
	1,
	Tween.TRANS_QUAD,
	Tween.EASE_IN_OUT
	)


func _on_RuneChest_body_entered(body):
	$AnimatedSprite.animation == "Chest"
	if body.is_in_group("Player"):
		$AnimatedSprite.play("Chest")
		_on_AnimatedSprite_frame_changed()
		_on_AnimatedSprite_animation_finished()
		print($AnimatedSprite.visible)
		
func _on_RuneChest_body_exited(body):
	if body.is_in_group("Player"):
		$AnimatedSprite.frame = 0
		$AnimatedSprite.stop()
		$Tween.start()
		yield($Tween, "tween_completed")
		call_deferred("queue_free")



func _on_AnimatedSprite_frame_changed():
	if $AnimatedSprite.frame == 3:
		$AnimatedSprite.stop()
		


func _on_AnimatedSprite_animation_finished():
	
	if $AnimatedSprite.animation == "Chest":
		$AnimatedSprite.visible = true
		$AnimatedSprite.animation = "Rune"
		$AnimatedSprite.play("Rune")
		$CollisionShape2D.position = Vector2(-1.131, 1.867)
		$CollisionShape2D.scale.x = 0.5

