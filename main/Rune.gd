extends Area2D



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
	 

func _on_Rune_body_entered(body):
	if body.is_in_group("Player"):
		$Tween.start()
		yield($Tween, "tween_completed")
		call_deferred("queue_free")

#mostrar runa al abrir
#func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "Chest" and $AnimatedSprite.frame == 3 and get_node("../Chest").open_chest == true:
		self.visible = true
		$AnimatedSprite.animation = "Rune"
		$AnimatedSprite.play("Rune")
