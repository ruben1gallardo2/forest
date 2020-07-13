extends Area2D

var open_chest = false

func _ready():
	$Tween.interpolate_property(
	$AnimatedSprite,
	'scale',
	$AnimatedSprite.scale,
	$AnimatedSprite.scale ,
	2,
	Tween.TRANS_QUAD,
	Tween.EASE_IN_OUT		
	)
	$Tween.interpolate_property(
	$AnimatedSprite,
	'modulate',
	Color(1,1,1,1),
	Color(1,1,1,0),
	2,
	Tween.TRANS_QUAD,
	Tween.EASE_IN_OUT
	)
	 

func _on_Chest_body_entered(body):
	if body.is_in_group("Player"):
		$AnimatedSprite.animation == "Chest"
		$AnimatedSprite.play("Chest")
		_on_AnimatedSprite_frame_changed()
		open_chest = true
	else: 
		open_chest = false
		$AnimatedSprite.stop()
	#	$Tween.start()
	#	yield($Tween, "tween_completed")
	#	call_deferred("queue_free")
	#	_on_AnimatedSprite_animation_finished()
	#	$CollisionShape2D.position = Vector2(-3.082, 8.534)
	#	$CollisionShape2D.scale.x = 1
	
	
func _on_Chest_body_exited(body):
	if body.is_in_group("Player") and $AnimatedSprite.animation == "Chest" and $AnimatedSprite.frame == 3:	
		$AnimatedSprite.play("Chest", true)
		$AnimatedSprite.frame = 0
		$AnimatedSprite.stop()


func _on_AnimatedSprite_frame_changed():
	if $AnimatedSprite.animation == "Chest" and $AnimatedSprite.frame == 3:
		$AnimatedSprite.stop()
	





