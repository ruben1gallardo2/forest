extends Area2D

var open_chest = false


func _ready():
	$Tween.interpolate_property(
	$AnimatedSprite,
	'scale',
	$AnimatedSprite.scale,
	$AnimatedSprite.scale * 3,
	0.5,
	Tween.TRANS_QUAD,
	Tween.EASE_IN_OUT		
	)
	$Tween.interpolate_property(
	$AnimatedSprite,
	'modulate',
	Color(1,1,1,1),
	Color(1,1,1,0),
	0.5,
	Tween.TRANS_QUAD,
	Tween.EASE_IN_OUT
	)
	 

func _on_RuneChest_body_entered(body):
	if body.is_in_group("Player"):
		$AnimatedSprite.animation == "Chest"
		$AnimatedSprite.play("Chest")
		_on_AnimatedSprite_frame_changed()
		open_chest = true
		get_node("../../Player").rune_chest = true
		

	#else: 
		#open_chest = false
		#$AnimatedSprite.stop()
	#if open_chest == true:
		
		#$AnimatedSprite.play("Rune")
		#$AnimatedSprite.animation = "Rune"
		#$CollisionShape2D.scale.x = 0.5
		#$CollisionShape2D.position = Vector2(0, 1.007)	
	#	$Tween.start()
	#	yield($Tween, "tween_completed")
	#	call_deferred("queue_free")


func _on_RuneChest_body_exited(body):
	if body.is_in_group("Player"):	
		get_node("../../Player").rune_chest = false
		open_chest = false
		$AnimatedSprite.play("Chest", true)
		$AnimatedSprite.frame = 0
		$AnimatedSprite.stop()
	

func _on_AnimatedSprite_frame_changed():
	if $AnimatedSprite.animation == "Chest" and $AnimatedSprite.frame == 3:
		$AnimatedSprite.stop()
		
	





