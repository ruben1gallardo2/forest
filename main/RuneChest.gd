extends Area2D

var open_chest = false


func _ready():
	$Tween.interpolate_property(
	$AnimatedSprite,
	'scale',
	$AnimatedSprite.scale,
	$AnimatedSprite.scale * 3,
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
	 

func _on_RuneChest_body_entered(body):
	if body.is_in_group("Player"):
		get_node("../../Player").chest = true
		$AnimatedSprite.animation = "Chest"
		$AnimatedSprite.play("Chest")
		yield($AnimatedSprite, "animation_finished")
		$AnimatedSprite.frame = 3
		$AnimatedSprite.stop()
		_on_AnimatedSprite_animation_finished()
		
		
	
		

	
func _on_RuneChest_body_exited(body):
	if body.is_in_group("Player"):
		get_node("../../Player").chest = false
	

func _on_AnimatedSprite_animation_finished():
	
	$AnimatedSprite.animation = "Rune"
	$AnimatedSprite.play("Rune")
	yield($AnimatedSprite, "animation_finished")
	$Tween.start()
	yield($Tween, "tween_completed")
	call_deferred("queue_free")
